Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496E7305E1F;
	Thu, 27 Aug 2026 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834548; cv=none; b=CVyauTCI4W96tC/sHIn8s7SFeXpETawL+kcInSt0Zf4q94O2KOsiYq++mv2afbwMU1TF1tZJ+ePfLaR5VdGDljneJVgYuAtoxMPFipFmlnoaw1OgKHXgFYn3+JsJZ8fAXV5MyksWo1vfFqskq9rhDaRSgBWwpCd82cxbRiyfp6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834548; c=relaxed/simple;
	bh=LfejsEYIkfs7O+ju/v6kaMx0V67vXkPM+hGIWLVIk6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zz3sJrPUpJZcxZV/cM6lm/GPGg5Zs8QLN1UZTzKAn6TDfXvMfmvOMYeYYp0LdTnmnArfgWPB37+uJOwl2RrLJTXnkkCb/+pzgoDxG7CjXJvcL5TUj0QTB5dc5pnvxrnDmga/sKAVdJX2drufy0IL9tIE3nFJrEHob1nDNtgScw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=mbVpRefr; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="mbVpRefr"
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 7C8371603F5;
	Thu, 27 Aug 2026 12:42:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 9C7311B;
	Thu, 27 Aug 2026 12:42:19 +0000 (UTC)
Date: Thu, 27 Aug 2026 08:43:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: =?UTF-8?B?SsOpcsOpbXk=?= Jean <jeremy.jean@oss.cyber.gouv.fr>,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] tracing/user_events: Clear copied tracing state
 before fork duplication
Message-ID: <20260827084306.54c13b60@gandalf.local.home>
In-Reply-To: <CE51AB37-6584-4001-9375-24AA00C8B79D@mainlining.org>
References: <20260826214414.1971632-2-Jeremy.Jean@oss.cyber.gouv.fr>
	<20260827080839.35e44d04@gandalf.local.home>
	<A4F580CE-2211-4D05-9D3D-15AB427C74A4@mainlining.org>
	<20260827081915.320fe2c3@gandalf.local.home>
	<3beb0339407a35c0b995856eae74d870@oss.cyber.gouv.fr>
	<CE51AB37-6584-4001-9375-24AA00C8B79D@mainlining.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: i66wd9auamgh1p9c7fpg1b6icbw4dafg
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 9C7311B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18anPmM2HcXYqVh8Ya5Ygez3cFZxDw4PWU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=E1bno8+O9gWkiYIxCukvQRC2e3HJS7C07bQiKiDGCaQ=; b=mbVpRefrVDmHu5TzvNDosdmOjWVu0jQkrzri8d9iayH9y9ICY9oazHLoTzIGmiIh+25qwva12wpj+0AZubeQXlVzG5O4MJHr+nu9zM5YrTsqAQzjc8O37l9mZZ3zBEGzakZE8OPG0XRJjkJrgkL2x4f6oNVIbkWMbQDtC6vAJ5M=
X-HE-Tag: 1787834539-100005
X-HE-Meta: U2FsdGVkX1/YFBwGt/sm5zi6frHcJooX2m+ZGJWttTudLUbUn8NO9/GBCV3pHj/Ch312pjniHj3RsAjs6hprICbwmeQ/U02LppujiJEiYKJysMUGtQJmB2WxreLBwKktXuSmCpE2mRyvoJq3RsUcaEb6nrCDMLG0o3mEOXcPFiXMpXqiXu1qnciQNP91Qaip3DpnPrC9QIZ09u0wx4F8HBrCD+r2PzSAnBJB1HuP2m+s/6XMZo3307IpbxbBlQgl3wHtPbvXgnQQn5s22ADT8er1auX2eCXvpYnbD5QZnxrNqIaANy2R16klSZxhqGvdJAwZHxDs9r5R1mgxcleNB6/6o2VKSpsAvto6kty/SzEC7uXvr8YGCMw2yt0DqDQu

On Thu, 27 Aug 2026 13:29:20 +0100
Bradley Morgan <brads@mainlining.org> wrote:

> I review on
> 
> 
> 1: does this do what it's intended
> 2: does it fix X?
> 3: Any comments, any new functions used instead, any way to get the line count shorter?
> 
> 
> And others, I apologise if I'm wrong. I just review in a different style.

Please just focus on correctness, until you understand what the
maintainer's preferences are.

-- Steve
