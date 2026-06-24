Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63569325706;
	Wed, 24 Jun 2026 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782326235; cv=none; b=WxsG7dH+4WQep2fhMYpQjo5zY32jovVjCx1Xg5O0YX1k3nOevP2TY2tFuDrckfpM1qwB/Ig//UbMQbqZURcuxLMGRXIAdmqVpzQlrphDZA02XiWSbGgZGnHvVgXkNNxP91RiZ3JDeVF8jhOtv+sUxnPEH14FeiTAbKZPVEZn6GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782326235; c=relaxed/simple;
	bh=cYgKJTc9gkW11/NnIWcI7YTOuDswywvAsTQV0uV3LR0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=EXgWvVqc9dS7naJdN5eH184B93bOeQsjN+hEVwMLpfVKG6lWwtdSAdazeYWXKndAXkXlaQFhOSmkEkvACwmveDPbLb8EVAsRIgt3YSaqO+h5d12x4BQGr8MHq0T855C95suPgBuIisq8ACwFDtprtyL0BA6sM4pbxV9XgP5njt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=abQkgu7N; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="abQkgu7N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782326232;
	bh=NI46s4EnJvuP923IrCreg9YPlL82QCQYf/Ag8Yhe+Gg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=abQkgu7NFxeoFje3tY15Ct7rEGE1UYqmUqhAlpWEFcuJNYYjvc6tHdnVP5WbkUQdl
	 q76dm//6kZk9Tu1OxSyWOHKn6vyCa7jBDOe+zcCLX5SvFeVwlk6bs/yob8mdnqVMg2
	 Yh9gU3E0XBtHs6AEzIEMQDd6T2j0yGnfEKFJatIM=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4glrJS6fykz10tT;
	Wed, 24 Jun 2026 18:37:12 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4glrJS2KFkz10s3;
	Wed, 24 Jun 2026 18:37:12 +0000 (UTC)
Date: Wed, 24 Jun 2026 19:37:11 +0100
From: Bradley Morgan <include@grrlz.net>
To: Marc Zyngier <maz@kernel.org>
CC: Oliver Upton <oupton@kernel.org>, Fuad Tabba <tabba@google.com>,
 Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Quentin Perret <qperret@google.com>,
 Vincent Donnefort <vdonnefort@google.com>, Gavin Shan <gshan@redhat.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_3/3=5D_KVM=3A_arm64=3A_top_up_s?=
 =?US-ASCII?Q?tage_2_memcache_for_dirty_logging_faults?=
In-Reply-To: <86ik77re2n.wl-maz@kernel.org>
References: <20260624160028.15591-1-include@grrlz.net> <20260624160028.15591-4-include@grrlz.net> <9FCEC7E9-DE50-443F-8E82-9FA22CA15ED6@grrlz.net> <6FBA06E8-B0C4-444C-B226-0B756C0172A7@grrlz.net> <86ik77re2n.wl-maz@kernel.org>
Message-ID: <548B439F-7DDD-418B-98E2-D7D6BB047A6E@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On June 24, 2026 7:25:04 PM GMT+01:00, Marc Zyngier <maz@kernel.org> wrote:
>On Wed, 24 Jun 2026 18:46:10 +0100,
>Bradley Morgan <include@grrlz.net> wrote:
>> 
>> On June 24, 2026 6:39:16 PM GMT+01:00, Bradley Morgan
><include@grrlz.net>
>> wrote:
>> >
>> >Note: Patch 3 seems to conflict because of patch 2 (the comments)
>> >
>> >
>> >Oops! :(
>> >
>> >V4 (after people have their review go), will contain one commit (patch
>> >3) with the updated comments.
>> >
>> >Patch 1 and 2 applies as usual.
>> >
>> >Apologies for my messup. 
>> >
>> >Thanks!
>> 
>> 
>> Actually. Hmm.
>> 
>> I'll just drop patches 2 and 3, I'll do them at a later date, please
>> disregard patches 2 and 3, patch 1 doesn't rely on 2 and 3..
>> 
>> If you guys wanna have a look feel free! :)
>
>As I suggested in my reply to your hasty v2, taking a few *days*
>between versions is generally a good thing. it gives the reviewers
>time to chime in, and gives you the opportunity to reflect on what
>you've just written (reading your own patches after a few days is a
>sure way to go and rewrite them).

welp, I guess I learned the hard way with the hastiness of my V3, (that's
kinda why I dropped p2 and p3)


>Actually, by posting more often, you are guaranteeing that people
>*avoid* reviewing your stuff, since odds are that there is a new
>version coming in the next 10 minutes, so why bother...

I'm not planning on posting another version, until fuller review concludes


>But hey, that's free advice, so it's probably worthless.

advice from someone with experience isn't worthless. 

just stupid me decided to unpark my V3 and send it :(

Sorry about that..

>	M.
>
>

Thanks!
