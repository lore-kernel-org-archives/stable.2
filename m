Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84188305E1F
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791647641; cv=none; b=G4LZjLa7SQoxlswQbntgqTJiXxbdQSi8XuG53+dxX9erJQrTbdU0UGkSYxL0BijL7DagISXtDLZGvinTZMCkgaUFewtrzlCVQhZYL0Q/iuhdiWfAwiuf41E2JLP8lUAk1MZmHvAoh+q5r58hkoOrVZrl1q8dIAZ9CkvxOyRyiTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791647641; c=relaxed/simple;
	bh=H3KHa2/o/VMC6EDqcdi1FNuJ9/qPNCRnhV5AgFomkyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zm9lX7SrAoGO1BNgPk87gTtdPkCzeOPPtGgrODQzywGAVUtDnJs7CYT13W7aMmmQcL4Gr8pp2nxOSBt4xpjzcfSUNE8gG6ILE75UbBPoZ/M39LjI70sY0+tIhlT0ErggS2Aex7uZlSy1NfC/yK7B6u1BBsS7CPAVaTsdmS8YggE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=LEy+UkFk; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="LEy+UkFk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=H3KHa2/o/VMC6EDqcdi1FNuJ9/qPNCRnhV5AgFomkyI=; t=1791647640; x=1792511640; 
	b=LEy+UkFkvidHOQEYgnLMvfeudSWNzbPFoddC/gMUqSy5kbSjjntGW1/suwAacuq0TA0DtQn6j5o
	VADohANjhM5knOnP8GQS64LEWZ/GAFJl33bQ8OSbyoQNFSGUecorDmPOsR8Xv07Uk2GXhTP6FuVcU
	N4Ue2dIfGqAYICUyPzk8/xTPjTll01A34s965oTtbQRqhPKw9gruuSfkC29E0gifrEBrWhjVwrPjQ
	SyVYttx/mzSJTYsZia5hvfnBOsm+awDSoTYt+Fcd4tubGvKswcWHmkaiObaNRHL/3yfddOCV7jB09
	D/pS2CoC058XeOimxxQjtljXopIxZTPCTEoA==;
Received: from mail-dy1-f174.google.com ([74.125.82.174])
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xFZOZ-006RDy-HA
	for stable@vger.kernel.org;
	Sat, 10 Oct 2026 11:53:59 -0400
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35903777bbcso228592eec.0
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 08:53:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzuIWJyPjrzj3Yk3b3me36Q1bsc5PepG+35SDv8PXJmcpv4b0i2/r9pEQ83UCI5LYdswIQlfNY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJP9ep379qw2hHrWq/tW8RDnPFGIEdl2uZgUbGobyFKA29xXI9P
	DZEv9WqxS9Ff0D5rs9aRhpFsEhtWR+htYbRsvDMlMgcd5lCQ3Rfpc+P590T+OZVuwCylHDMz+ID
	2v65SsZ9PD85BSysW4IQflAPDaDOkG0Q=
X-Received: by 2002:a05:7022:b057:10b0:160:a80f:3ed2 with SMTP id
 a92af1059eb24-16a5dbfecb9mr6463396c88.10.1791647638611; Sat, 10 Oct 2026
 08:53:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009221957.760606-1-nickolai@csail.mit.edu> <asolRA3vLbKEZ1Wm@xhacker>
In-Reply-To: <asolRA3vLbKEZ1Wm@xhacker>
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
Date: Sat, 10 Oct 2026 11:53:47 -0400
X-Gmail-Original-Message-ID: <CADGQE7Hm2vnkh=n3s49XhRSa6HBG5vA4Pusd06-97GCF3uZuAg@mail.gmail.com>
X-Gm-Features: AclHuK8OBWpswoUnQNiV_qXKHgPLCSUObfgFAB-AqpsBhKNELovNo-sFkcnHWz8
Message-ID: <CADGQE7Hm2vnkh=n3s49XhRSa6HBG5vA4Pusd06-97GCF3uZuAg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix icache flush being skipped for a second mm
 mapping an exec folio
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 8:05=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> =
wrote:
> I guess the reproducer is just a simple c program.
> It would be helpful if you can paste the reproducer code into the commit
> msg as well.

Sure, added to the revised patch (v3 sent by email just now).

I also fixed the other two comments you pointed out (thank you):
enabling this code only under CONFIG_SMP, and using atomic64 to get
atomicity on 32-bit machines.

Nickolai.
