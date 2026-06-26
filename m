Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282DB3ED3B2
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 10:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782469017; cv=pass; b=ftVSo3AAuUVemN03XI3GGYUX/kpm3CC/WmsrCTjhEr3FxY3xsTcE5Z1G0M776NvByrfos/9PdzZlt2zowlim0h9YeSDwseww3hIrjUHHc1PryPxnSGbYL/sY7hE2/e8l+8UjIy7T/62njcuPHUERe+dRnihIJb+jH5gmdjIBpDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782469017; c=relaxed/simple;
	bh=Q0VkRyZGMx8Ip+nI1uCNkWg9svwog6B4Nwe9YU0ExFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCmqf75epb4/IlpjazGJXvOyl7VvLhTxnFWlcAc4jDAL010SyN2EvkmG/eZIEjp1F7sm/Nuu2aNAoRiAfj3VlcfCCR+V8iGTY4ZnKzehp0hoLC2S263wscS7/cY0LJvLE3J0eRFqo4Z9Fu0wLjcrtqDKy8+MMapamTd/ctPWA2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=PFif3UjD; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="PFif3UjD"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8454160043aso639959b3a.3
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 03:16:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782469015; cv=none;
        d=google.com; s=arc-20260327;
        b=DQeIYnY6oG1DO6sHmCu8JZA2KBaGqVoMQQWlMqINg9/EBmafl7/1gepatrhSeaM2s9
         bZBXqlS/ud/Ex5135IX8Aqia+tXnuEeahE2SDZPj/AxDMsz55+6T+Vh9AWK3ZC2z1l60
         QU4jA2Fv49X4DbRVPZm8cicIm29KbKephHoDmEvkazjx7o1ElaaM5ciaTcPCENkqx7u7
         4czUsVg5gT3No5jr/ZBm5OHd2UrQ1D5jis98Vx/JriKfcTgOUXE2hvGP/O6rEeRFyn4N
         HyTxVqWMLZQR3OJv8BSDPG7zVb/fk5wQgObIyxbiJJXtRMrje837XTbYYArJjvP6p33Q
         wORw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q0VkRyZGMx8Ip+nI1uCNkWg9svwog6B4Nwe9YU0ExFM=;
        fh=dbOxHXsEMaz65+fLuDr3243AKXsRZWhjHwlnEa19KLQ=;
        b=hYIux3H+PuR31cVt3gwbeCAqUAvTxvh6Wqpb4IuF5VDbHa6yRfoXSWub1Jm07aGce3
         Om300h4231/LabdvG8Cwzq6uTcvl5epnGpd3bJT1ISxqnupIOABV9iVTbA+u8KIUTiVH
         BdsQPT9VBisBlRPwWJC88zMf1zBwKVAVNsGtyisYXGzDWy6mLftf5IQ+OwkPDFyVqX/7
         fNL4chPAcvQu1Aolec+CyAeJlEqs1YBcfwOdkhPWRjcOszoTnLlrxb7Azqj9ccdRJRAB
         yMd76j3iZhuCNYrX/Xm+nF2YIJvoM3dFqOO0Z/59PG5BUUxvBBrUHFgrleggjrZMLYlz
         LjHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782469015; x=1783073815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0VkRyZGMx8Ip+nI1uCNkWg9svwog6B4Nwe9YU0ExFM=;
        b=PFif3UjDTqdX/mCLhIAN/C9cyGlL9i0cierzz341tur+BTBYQ524X2t8djIlEZWWSf
         NhddQgXRaxqKG5r0hnFR50m6RR6AQZMulEmghsQKoWEpyJVi2EvpYJpAuYmdR8ENoV7x
         4y5zwm45kQX0Mgksgw+5494nqoKhqGcL3NqVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782469015; x=1783073815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q0VkRyZGMx8Ip+nI1uCNkWg9svwog6B4Nwe9YU0ExFM=;
        b=LSkise7RLMHvlzVydTIrn8802RKJ0XmfmnMzs4TsckHmNJWnwlAIcWLgv4cHtQ015H
         Ea7jX5hl8YvlgxNXQiLMeRPz/mEsvC9aS4Vls2oCgbux5DcqCR0qbGnrz7PsM/XxahHj
         /IaHZp1DwA2xArH0T/zgOMVI2+E6R/CUGCm97RLFLGKAFUwv/cSij4mL3RGKeGDnON0d
         5abFZx7WJaNWveMVWZHWB6AzjKAQjPkjQ52T0hMcCHEJFJlP7qEnot438iRWDHpGc37w
         uN7gcsr68JTU4Mh9P7JQcNI0zsLilLMrWuvQYLjMbP1EExR3I3U7uwkHaC2mnJMwTXgy
         h1gQ==
X-Forwarded-Encrypted: i=1; AHgh+RoyBEQMkFpJFPXRCTwWrB/Qv47U5X4/Ud/LgTy85j5DbLDu1KRKuz5p7mTVYQ9XUOJvTHF87wE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjckcMALd74HLvwMDm6QNp8ktDXo4uskWin/nx5h0BAa9UmNzX
	Z6jnJT3Q4kXM6s94efPhD64j32BdjAt5aixanSnww781CFJnAvWS51aLeYqDiN+hkKSfdnSx+po
	cjqyVApo3d5GE8xO4LyQrRhGkhMBE3BO9ywsHkVbb6xqE4Gp849bXhA==
X-Gm-Gg: AfdE7ckUc+0zSDAYSifFZyZcEIKB9zS1SzraGq0gdZz/v7tzPDiEC9qAmVDzMOtnrLP
	9SJ3k0ZNkZHYvGW7vSQUwS2QV8fiOkLA2mPmqnEd5ddC/GS2wiFtuLO01bnQx2E5ykejWibRi5F
	fYzMD/dhIoMZyB0VIXYvcX5A7xhrimoPVF3TennXz617r3R1/jTYhVro3WdOrGeGpiSxsLTvbHc
	GxstcI6FROrpDL9B6dtxBipmzcrTNRmYhHjGWRASTrow7TRojWfmeOWriXZQano2wogF6uafw==
X-Received: by 2002:a05:6a00:2389:b0:845:d0d6:b9 with SMTP id
 d2e1a72fcca58-845d0d601bbmr147884b3a.4.1782469015279; Fri, 26 Jun 2026
 03:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624224016.24018-1-jhs@mojatatu.com>
In-Reply-To: <20260624224016.24018-1-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 26 Jun 2026 06:16:43 -0400
X-Gm-Features: AVVi8Cf2P7f9br_adTOBaN-EcnhYa4YwGzb1Nua8DRNE1VC5vPu11kXmT85D-_I
Message-ID: <CAM0EoMmJZxAbOsyW7bBp0DbTTiQKZeGaaBHPEw45D5b6DKDEvg@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net/sched: sch_teql: Introduce slaves_lock to
 avoid race condition and UAF
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, victor@mojatatu.com, 
	security@kernel.org, zdi-disclosures@trendmicro.com, stable@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"

On Wed, Jun 24, 2026 at 6:40=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> The teql master->slaves singly linked list is not protected against
> multiple writes. It can be mod'ed concurently from teql_master_xmit(),
> teql_dequeue(), teql_init() and teql_destroy() without holding any list
> lock or RCU protection.
>
> zdi-disclosures@trendmicro.com has demonstrated that the qdisc is freed
> after an RCU grace period, but teql_master_xmit() running on another
> CPU can still hold a stale pointer into the list, resulting in a
> slab-use-after-free:
>
> BUG: KASAN: slab-use-after-free in teql_destroy+0x3ca/0x440 linux/net/sch=
ed/sch_teql.c:142
> Read of size 8 at addr ffff88802923aa80 by task ip/10024
>
> The zdi-disclosures@trendmicro.com repro created concurrent AF_PACKET
> senders on a teql device against a thread that repeatedly adds/deletes th=
e
> slave qdisc, together with a SLUB spray that reclaims the freed slot; the
> resulting UAF is controllable enough to be turned into a read/write
> primitive against the freed qdisc object.
>
> The fix?
> Add a per-master slaves_lock spinlock that serializes all mutations of
> master->slaves and the NEXT_SLAVE() links in teql_destroy() and
> teql_qdisc_init(). teql_master_xmit() also takes the same slaves_lock
> around those updates.
> Annotate master->slaves and the per-slave ->next pointer with __rcu and
> use the appropriate RCU accessors everywhere they are touched:
> rcu_assign_pointer() on the writer side (under slaves_lock),
> rcu_dereference_protected() for the writer-side loads (also under
> slaves_lock), rcu_dereference_bh() for the loads in teql_master_xmit() an=
d
> rtnl_dereference() for the loads in teql_master_open()/teql_master_mtu(),
> which run under RTNL.
> Pair this with rcu_read_lock_bh()/rcu_read_unlock_bh() around the list
> traversal in teql_master_xmit(), so that readers either observe a fully
> linked list or are deferred until the in-flight mutation completes. The t=
wo
> early-return paths in teql_master_xmit() are updated to release the RCU-b=
h
> read-side critical section before returning, since leaving it held would
> disable BH on that CPU for good.
>

sashiko-gemini's complaints:
https://sashiko.dev/#/patchset/20260624224016.24018-1-jhs%40mojatatu.com
seem bogus to me (someone correct me if i am wrong). I am only going
to address the first claim of "TOCTOU / "resurrection" race in
teql_master_xmit()"
teql_master_xmit() holds rcu_read_lock_bh() across the entire
traversal. teql_destroy() freeing can only proceed once the qdisc's
RCU grace period has elapsed - so where is this TOCTOU? Let's say this
were true: both calls hold the slaves_lock.
The other issues are of similar nature.

OTOH, sashiko-claude
(https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260624224016.24018-1=
-jhs%40mojatatu.com)
does make some valid claims which are low value, so not sure a resend
is worth it.
For example in claim 1 it says "Should the changelog mention this
teql_dequeue() site too?" Sure I can - but just because I provided
extra information in the commit log, which I could have omitted, now I
have to add more info? ;-> The second claim is "rcu_dereference_bh()
should be rcu_dereference_protected() on writer side". Sparse didnt
complain and i dont see this as breakage rather a consistency measure.

Unless I am missing something ..

cheers,
jamal
