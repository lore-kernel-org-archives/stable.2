Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FF7493634;
	Sat, 22 Aug 2026 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434893; cv=none; b=su8tgPlsBkFX5D10/zJQR1fnCz25gcQRrBO0/ljUkh6kuyKMb6T6UfOBZ/fsocW1d8qYtre7Q/rnHNqSX5dKYLDiDwJzFQ1rAmEBBOn9lstfflbTUahaSBI0FKcwpJmQXda57yOePAaPRWdNOQ/EgVs+WtsnrD4t46HYPGMGVF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434893; c=relaxed/simple;
	bh=dtSe3C1Tc4gxt6nN885cuKTw/xAqg6X+Lj8V/W6XzFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRkc+/Nl6o2mH09e4CAeQeUilFkGjfZT9eQp3SLeSX4r9VIijtxkLYTdsrqUjS0L7or49BceAHtZZ8GL065YEl1EQdR1kTasgPHeG6DNxpEfu5O0YI8B+KiRPFKg7lFVhv0kmPHHlxRpgkBN3E7UG3LS4xdSkx6tRnKSrNWLfEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=MPnoNiz8; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="MPnoNiz8"
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 70EAC1C0C8D;
	Sat, 22 Aug 2026 21:41:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id A9CFA2F;
	Sat, 22 Aug 2026 21:41:06 +0000 (UTC)
Date: Sat, 22 Aug 2026 17:40:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?SsOpcsOpbXk=?= Jean <jeremy.jean@oss.cyber.gouv.fr>
Cc: Bradley Morgan <include@grrlz.net>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 mgorman@suse.de, bsegall@google.com, dietmar.eggemann@arm.com,
 kees@kernel.org, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, vschneid@redhat.com,
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] fork: initialize function graph state before
 copy_exec_state()
Message-ID: <20260822174053.26aa2f56@fedora>
In-Reply-To: <603183e5d6abcae2229c61b8e266e60c@oss.cyber.gouv.fr>
References: <20260822195321.962383-2-Jeremy.Jean@oss.cyber.gouv.fr>
	<4E2240F5-1211-47CE-AF04-24E1F0BC4707@grrlz.net>
	<20260822170928.1acba2cc@fedora>
	<603183e5d6abcae2229c61b8e266e60c@oss.cyber.gouv.fr>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: A9CFA2F
X-Stat-Signature: qz1pi3axyizt7u4bd14d7z88nseecyie
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19BMXAzeE7Pvu0yytgC++z47nFrOeJ74ek=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=dtSe3C1Tc4gxt6nN885cuKTw/xAqg6X+Lj8V/W6XzFA=; b=MPnoNiz8iaLPu+lNvzqdC+gYu2ZbtLvWJQTMz4QR06+RJZ7Gi8fhIgWPB21btFeWC3kayltX0OdCqN5Bknio6vGmHekRjxWHlm6xIZwx0rsunIPotv7INM14WrVIv+u5LrJhi/zjCV7YROL6kxja9lpXVnTpJ8p00g1gotTx29o=
X-HE-Tag: 1787434866-292068
X-HE-Meta: U2FsdGVkX19z+F/YeVL02ioTYmPD+aS75hp0rzfxU80zUVnxchF90tHh5jg4ATMUGvaWfzMOYjQktfE+vO5ogejJtU9HLYuFoffslp/90B23PGlakWB2fj6spMaAkv2ZFUQs9pU6wI1s4W0kc+IaO96YlPdU7DvwwokOhY19neUdLwp7ESgFWBvH9hr5Etcy1z9QYaf9g1MiwegSs0g7HVv5/lJgRKXbgohkH1OKpDQLsEUtLLgrsdnK6DPWpmi0o43JCFyTN/VCt7z4/6yRyGjAEJV2MdkOfRyGuI2Lquc2JqXETLFOwaI2mSo7Ocv6ivlAoElfzg4/MIXxPjoPn6/WyK4m9/S740fqJbXygm+YTFfpCb4MNNTwyxVdUEgv

On Sat, 22 Aug 2026 23:12:35 +0200
J=C3=A9r=C3=A9my Jean <jeremy.jean@oss.cyber.gouv.fr> wrote:

> Oops, I did not know that, sorry.
> Do you want me to resend once more, or that's okay?

No need. It's in patchwork and I'll manually add Bradley's R-B tag and
start testing it.

-- Steve
