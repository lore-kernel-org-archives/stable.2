Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ACD2DF15C;
	Tue, 23 Jun 2026 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782240673; cv=none; b=MSxTg7t46UCUpeuLfb4nyVJmhIjNTQSvEMlZntFTcljJdy9aLipdDwVTMGnX/1/2wY5Fn/2C/5vDUddHene7ph7cdmISucukrQeegV1kh1MbFToD+E8NgqK9Rxe0UWErpiXczmZ7QG+xLheegh3KZlVfurJ9AA/b6y3ybtGjSeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782240673; c=relaxed/simple;
	bh=mA2uhvfC/x724eYMluHFeY+d4iPLfQZaUspe1Bc9LSo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hGi3z5pZrFGxi81X164Uauzpu6wqpAc5egH92Zkq9nthoQPkE6t7tTdECa7bFzoJLEsYJXCD2OixHLfUymMFcYfEMS4PZ5267suUX0098fx0iEcj/R3dVH3FlSqDbxk/TlRqMQq4hVfyUqJQn1Scu0maN+iIg4Gig//vtQ4pseI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=t9P1Hu1O; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="t9P1Hu1O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782240668;
	bh=xlRXCKKPWACvAnS4iALqH+JPpXRCzsovrB7Jtm/n3rM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=t9P1Hu1OLFc2SI0lw8Q1OSGHqJXhZIigwJmYPR9UQAtEWYqHKcpENs1qU70YjmqE2
	 GDRoWG/Mi67Tuc4U04Aa5cmTFENIk3xEnejiJaQws/ba5yQaz5XxpprgPeNQtke66S
	 m4P7JmELgeB/mfU6JvuVD1cnZvrxWngS8UfkcmFw=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4glDg029xDz10ry;
	Tue, 23 Jun 2026 18:51:08 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4glDfz65FMz10rw;
	Tue, 23 Jun 2026 18:51:07 +0000 (UTC)
Date: Tue, 23 Jun 2026 19:51:05 +0100
From: Bradley Morgan <include@grrlz.net>
To: Marc Zyngier <maz@kernel.org>
CC: Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev,
 Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Steffen Eiden <seiden@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Quentin Perret <qperret@google.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/2=5D_KVM=3A_arm64=3A_skip_pKVM?=
 =?US-ASCII?Q?_cache_flushes_for_non_cacheable_mappings?=
In-Reply-To: <86pl1hqiwj.wl-maz@kernel.org>
References: <20260623160339.15143-1-include@grrlz.net> <20260623163756.4591-1-include@grrlz.net> <86qzlxqjf3.wl-maz@kernel.org> <5925B41F-0F57-4BCB-9F93-7600878ECA27@grrlz.net> <86pl1hqiwj.wl-maz@kernel.org>
Message-ID: <95A8722F-D486-4030-BA51-9117434C6E63@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On June 23, 2026 6:13:48 PM GMT+01:00, Marc Zyngier <maz@kernel.org> wrote:
>On Tue, 23 Jun 2026 18:04:07 +0100,
>Bradley Morgan <include@grrlz.net> wrote:
>> 
>> I'll go and do V3 with another sashiko suggestion. I'll fix your path
>too.
>
>Before you do that, please verify that whatever Sashiko spits out
>makes any sense. I'm not convinced by its reply on v1 at all.
>
>	M.
>
>

Marc, 

hi, I have verified sashikos concern.

I am out right now. So I will give a very short result.


Sashiko is being bit dramatic with the whole "Critical" rating, but it
is real in another way


I'll explain it in the code in about 30-40 mins.

Thanks!
