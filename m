Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.74
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793975713;
	b=v5KdgVAYiq59goW6xsvf2U8wwEGNIw0FJ+AiKg2Ym0Vvq6S0pdtMVnBicggrCsF0jylF
	 fIZZNW4OJWU74f/zQiocGKScHQVS971FeAj0RHTvK03mpqtIegchf+Q0LDQgqanDvizQx
	 zIkhIGb6KDecMnxkFS54ucqG/DxjpkWbdWnnmhz5xv3FC9g36scthA9RkTInbpJmkz9vs
	 MV1qpilKz521V4qydlcoD05GtmShxtW5m5bcMQnhCv4Uy82peKuSNOGshesY0MNp6QIxJ
	 LM2sPYZbw/pylEfEKAW0gVjPOL1JSiPNTdgtoV9bLxdyXHQ4gi8POnjllaDjszZZ1GA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975713;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=AgxbqOaoVM9+7Pj0+8CQw7G3IaiuCjj7kRy0IPi5eVg=;
	b=XBL4dL4YSFvu1DKiCz+HGPm8toSVg+UNmOlbz77ZteyoMPGXumftr37j2MNGIFwaKlcZ
	 GUcFkI0r0VfFkR0ys0l1iVJqba5GttQHdoCMVxwKf9wuKdI1IeaWCghDQ/3Kuy0Srff5a
	 L/4HJbnn04pHgMcSe3aqtA7irCBtcW+wct6NotRK5JwN3jhcfnGCvzb/GusrsF6GswhVj
	 FpsSGuv7fLbIvC5CuQ9tjlZrGdJRiffDuL5Ba/tbkrExf4QopEcXhva0ofRGFj4e9/LrY
	 4FOjNxkX3lPjAgMdtgEoOtxxltz6tUEPcIirT96lsHz8pTvFEx4fQLP+E6T7F5K0VtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b="Ma+/RZzQ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FC9606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56FC9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=Ma+/RZzQ
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6DcSpO1329598
	for <stable@vger.kernel.org>; Fri, 6 Nov 2026 09:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps01; bh=AgxbqOaoVM9+7Pj0+8CQw7G3Iaiu
	Cjj7kRy0IPi5eVg=; b=Ma+/RZzQRAikshvpTwR1Eb4FzE9gsBtnnc5LGsWWCojA
	AZBj2PdwgHcwxlq9AD6KjiX1dJ6otI/lgVtK7TMCP/zaJAE2lhFayZbmAfgmLPt5
	QsBoDuhurAzVoZRIaGDQJRkuUX0wYVDr4HDPlJyadIGYaWUH7PVjUPyd2k1URpig
	eymuvPUPbXpWjkZs5IGZlLVwePmBqAqRT4GG1FN9yFOMBpvx/KIYkZZW9mNbSPwG
	ZettMPQWsQeSk3oL5NOxwAjcDI9WVmStSr4smwpckP6Tjg+C/mPR4NgcI6uTWXVH
	SNYmQm8Nkx0cVvB3CE38ko6Rgzr7SVDg7CFcI54aJg==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hs3pcbe2m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 06 Nov 2026 09:35:11 -0500 (EST)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b309405195so5093937b3.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 06:35:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793975710; cv=none;
        d=google.com; s=arc-20260327;
        b=j63qBxKHYkX07tKZTkwuXxA7Mhx5rwtBH8cr11dl5dN0lXlDZjVbQlCvWXLKbYSvXm
         MSxnq4KSB2tDPO4lw7IPJk/dsyqmIFfRggoJ/ACTBN0DVysrDt+0CrHmLxhvK1LQ5IXf
         /hHEibIQD0M2trJ0d3PbcKArlmO7WG6FSw+d/eA7n6UjQzkArcpVl4MCdvhEAA+4KJfV
         09ytrN6FLy8mQ0BJfgO6xWNgWkls7YCMBPR3cjqrhjkmVkIbt6PteulgcixfrH018LEW
         jcw+OqWv8/1xrK5C3AWg25SCbaYTVIX7HAV9Q2qMyRv0Y0PQTHpktNdfpsaNx+ao9AB2
         85ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=AgxbqOaoVM9+7Pj0+8CQw7G3IaiuCjj7kRy0IPi5eVg=;
        fh=axbkKgIXPYWt3dkm/coYVxYqJ2HhAC5VYegOdZEvqAg=;
        b=HYAjgAo7TtKX5ZB7VPwb8qM2QP4cSzkH3YJYRwMX7O/GO18FGxy5PPWzUAmp2LDA9/
         w4BsiEOqtuJnizOQv4zSsyx9gFTyrDIC+fvxi3DkPDA200PssxCPO7ensMp8x+Hc06An
         k0JEEJELuBAw4v9ZUFRfzy6S6o6bHOMyC1Z+du4UvwjAoOE9/YSe1ZJwM4ngAMa4as6M
         El2y/gyM2UYaRehf/mB8UE/XwrpJ0woq1ZXKNdQnJlHcNSHs0rA+MZiCJYyrB8znxPwB
         bo3BLo4ZuYMlEJsEpCsppAFifHBLIpAuENH+u0V6ooPWbXNvAE8gyD/Ffn5kJKFiikYu
         XoDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793975710; x=1794580510;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AgxbqOaoVM9+7Pj0+8CQw7G3IaiuCjj7kRy0IPi5eVg=;
        b=X0lDAzCkIHfZ5aJDea8jTuVKAp3mzfIn4+JQjtnx5n6txOocea3aySGuQ7ihMbd8IT
         HwLs2G9lDWlTl5zO4WBFfp74Ck6M7DLDo1sPyjMVW+HYRXnb6wSh9l8CYVLOgJ44dxFo
         qYlyfACNp1OMs3DjOhanOAKqOAGqa/XX2YZUG3IPUNfyf5hc3MahCy0B49OXqQMIdT/R
         t/4LCfqJjNRTM1cxojJFLqNMMO7hmE2HXjSCxLFOHrfGWRxrXh+Yd8NQLy9OccwPQYGh
         8ffNywq6r+fnJB00G4Li2fnswFGCz/Er27aZ7bYqGo7ggFqASGIUHRWSf9TGOpXeG4kU
         Qf5A==
X-Forwarded-Encrypted: i=1; AL+hErF7enPVeMx5asFlbVZl6V5MpDs2odDam58Bs4esrG1TfSKCWnuIwvrHYwhmobQAM9aI7dHBQvY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FWS4G4I1cjjkmFgDawJ6nI/KaX+mtZGTxgl04M6uS8TfdjSmw
	EcEe6PEPiSI3VO/BtgK+Y31OyXtHonhqsia8rEjsp8NCee9XMVNGCb3duiGPx29fW0Y4I79ZkGk
	Un+2mVljzV3TCbil8UcqGqixpgY4WN4JSNJl6xnGD0b1+r/CPJjJCE8sZSqgDVJACf0305ImN5x
	3fpuRKQVAOeBdHgnsfH8qKSK9kPPJG
X-Gm-Gg: AYBFou1eQnpgifSqdZK6hNZxF2PNmwC4jpBinLhObx2gEOLdfzV1PMWWXFwvISdq4hw
	T32bMpjt/xuqF0mNgdAvqxbohhZJ5AqFNfPDiEci6jhGeJwK5rJjGN7ilAL4E53CPNtBnrV5RWz
	Q/IkrzrGGqfFEFZovylW95ijswZd3+FDAzOi1flb5m8gK+J1vUIsNpQHRh+FLJZ1R7Drw1S8CMj
	ceElShpwEiQcy6UcIAeBXgoRrrwaKcSJZJ1T75UpK0H0efOR4r40OGTPuyag+6Y4deiDOPLmXj0
	XsQIYwiwKPRYa/BUnwMQ4rweArGUtPVX7Q==
X-Received: by 2002:a05:690c:dc3:b0:8b0:d027:c4f0 with SMTP id 00721157ae682-8b3417cfa5fmr14408547b3.1.1793975710485;
        Fri, 06 Nov 2026 06:35:10 -0800 (PST)
X-Received: by 2002:a05:690c:dc3:b0:8b0:d027:c4f0 with SMTP id
 00721157ae682-8b3417cfa5fmr14408337b3.1.1793975709944; Fri, 06 Nov 2026
 06:35:09 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-pin-barrier-v1-1-04ebf118175a@cs.columbia.edu> <CA+EHjTxoNcx4s4L2DRXLu6VydiG2N3OqRYr+kscghp0jVVwg5g@mail.gmail.com>
In-Reply-To: <CA+EHjTxoNcx4s4L2DRXLu6VydiG2N3OqRYr+kscghp0jVVwg5g@mail.gmail.com>
From: Xuheng Li <xuheng@cs.columbia.edu>
Date: Fri, 6 Nov 2026 14:34:58 +0000
X-Gm-Features: AclHuK9bdlU0f_EKHjmsScSdj7QwMgpM5fQzjjzMWksK2dalOcvjFLTPsgJNF-I
Message-ID: <CAPOPQMDYJ7rEHd0W6Re4fs2u3FVf_Qs=5wD_U8DDOccHwaSY3g@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Order a later pinner's accesses after the hyp mapping
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
        Quentin Perret <qperret@google.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Joey Gouly <joey.gouly@arm.com>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=Vs62kO2n c=1 sm=1 tr=0 ts=6aede59f cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=SMIg8bpeATqOEtpUIEIA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-GUID: v4ZIFtEMwLqvCu-NNDhGz3u_PFd-TtLf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1OCBTYWx0ZWRfX4dULQ0G7VZzv
 6Ht35QZNRGz9+pk0VHWE6wCJeZgH7QLgdjrNvF/QXUJr09XBHuD97xfknqozu4Oto3An+3GGdUi
 +/ZKpH2EegEwD1AXivHBll895u6gCttcBa+1E3jo4BVjTdOtuSf3
X-Proofpoint-ORIG-GUID: v4ZIFtEMwLqvCu-NNDhGz3u_PFd-TtLf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1OCBTYWx0ZWRfXzSoHsgRRhJwf
 mlYrz2wA2UApkC2z2za2rw3KKfeBj3F2Ej6IyBYvAdJd62qUpDAT7BnrzaP3a/9Fi6GgZJe1nos
 A0c5nm62q6eUyYItjIN8yNdam8o2ExowNJ029qWT/bF4osb9r4XKyeHFohDuWXY5WciM2e3LjEH
 OyklBbbdWcCIPuZC1nlfnyfJJYEV19SgGNJaMXW4DAXJ7c37J25S0qz12egEUj6W7KhqJ0M+Af2
 o/Pn2LZlZ1fSq3tFbYOjcqqiG2BhVCtnytlESn05AChMxmWeo/p51fHMHy3cdpBx1H+uDzlL/xo
 gajCobc9rjfuaSHrRUchrUDKGr5yZxiS5Pnkaulqoqlwoig4WLHFpTHnpzZ0po7hfQ92up2BtIK
 4sGOgzA5L7SiMngvhiMjt0GvNm0qU7XbufSkSH3681Kvu+sgKFwC1WvOdNpIJR13Xv86FxNNfOc
 e08m9+UtFLYfbqxeFpA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11957
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 suspectscore=0 bulkscore=10 lowpriorityscore=10
 clxscore=1011 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060058

Hi Fuad,

On Fri, Nov 06, 2026 at 12:59:36PM +0000, Fuad Tabba wrote:
> Could you also give a case in the message that a well-behaved host can
> hit? Since 7.4, two vCPUs of one VM can pin struct kvm at the same
> time from the __kvm_adjust_pc hypercall (cf533b4d3630), which then
> reads it on a CPU with MTE.
>
> Either way:
> Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Thanks for the review. I'll add the __kvm_adjust_pc case in v2: two
vCPUs of one VM pinning struct kvm at the same time, then reading it
on a CPU with MTE.

Thanks,
Xuheng
