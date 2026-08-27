Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA38723BCEE;
	Thu, 27 Aug 2026 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834483; cv=none; b=uVv5TKKd7oMU5SR7VFCSQKUDbvtW7Q1+KdrJdZyuPotyUyPbuMwr8NV87DaU6Ks0/6VIKCWCivgBq9FOSSZABn6zUKyJ7zkjNnZ0SkszTmLxu65rl1SJHgOTry7YIwybrCCaFBo88JF8VS0tpBHWdu4pSWsxewWG4FWW0ucFUAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834483; c=relaxed/simple;
	bh=AYLnfhHHeqd95bsgIutEAxRxecIAQZYovjUbRBUPbPM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvU6aCCHj+RI18pruyMWbq2Ry+ybeu2mMHOGkSykqJRf4aE21qRWa1TXP7k9PdZnwRykeTK+XlMWaljdFronVmb+LY8oaRlyO5PctqSGVA0J3IIlFcIkLG81A/ikpLm5Yw1jdbQAie5gHFlUMFnoA+jIdwWu0f21eems7boaklM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=mYYqiuNl; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="mYYqiuNl"
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 2A378A3C27;
	Thu, 27 Aug 2026 12:41:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 61E9320013;
	Thu, 27 Aug 2026 12:41:18 +0000 (UTC)
Date: Thu, 27 Aug 2026 08:42:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?SsOpcsOpbXk=?= Jean <jeremy.jean@oss.cyber.gouv.fr>
Cc: Bradley Morgan <brads@mainlining.org>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] tracing/user_events: Clear copied tracing state
 before fork duplication
Message-ID: <20260827084205.776f7cb7@gandalf.local.home>
In-Reply-To: <3beb0339407a35c0b995856eae74d870@oss.cyber.gouv.fr>
References: <20260826214414.1971632-2-Jeremy.Jean@oss.cyber.gouv.fr>
	<20260827080839.35e44d04@gandalf.local.home>
	<A4F580CE-2211-4D05-9D3D-15AB427C74A4@mainlining.org>
	<20260827081915.320fe2c3@gandalf.local.home>
	<3beb0339407a35c0b995856eae74d870@oss.cyber.gouv.fr>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: ggzpphufcf3p435khx4uxd6hb1zzymt1
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 61E9320013
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19YSHo9eWZBq40qy4Afec5+DmxVpZiQdqE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=AYLnfhHHeqd95bsgIutEAxRxecIAQZYovjUbRBUPbPM=; b=mYYqiuNlY4J2Pa7pOSbDQSQ0J2e6Q9zmG+saYDa7ImavWlz+CQ+Rw1SBdJnje1CddiLnuTkLvJNcHc/s9UA7R5Xg6S7SUOKTRmA/A9k2GwqSCWGlUNvgCvevTIsPaVXH5xNxPoTYy1lBtXf7yiwUfOjPCqAmcfvIW0FYPqednFQ=
X-HE-Tag: 1787834478-918267
X-HE-Meta: U2FsdGVkX19rrap3+extfATw51zC1sd35BXY/S9Rr4Mp8qdBtlpEVwQ57yd4AOxkpiKn1FKyiKs7ZYGcKH57iwwF+T4OA21UUmKvryPf2frgKdmQG+fTO4eL/8YaZ+JorQNg0lxmhXMRTKSnoV4NzK2d4fAgvKTmJ9lwzFu+h90zVur5e894QRn/RQJ1fqVo2tXZalebq8nsKTjrZrk6MBYRWm43rqWWWXrGLZ548Z13zpXpKnmImQKVP5djQenxMo8m838aKN2bM9UtICndFYNcktj5mOtg8Nb0FJb2wKlvnvnYyRTzYPCemURjTWmR

On Thu, 27 Aug 2026 14:27:44 +0200
J=C3=A9r=C3=A9my Jean <jeremy.jean@oss.cyber.gouv.fr> wrote:

> Thanks for this. I thought that my previous version was okay
> so that it was not required to read the details of
> user_event_mm_alloc() to get convinced whether user_event_mm is
> accessed or not, but it's true that in the end, this is not
> required. Your fix is simpler. Do you want me to send a v3
> with that simplification and the same changelog as in the v2?

Yes, please send a v3.

Thanks,

-- Steve
