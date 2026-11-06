Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.74
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793975481;
	b=nMFhksHAtVf2XqJ8VvnSc93sqnZSM6UoHtnd7+4pC4fJwx1a946zWdByxLsSA6yevW69
	 1IFVGNNv1FsWoVQuSGs5REGX6mVSDKTG4AqW+arhT+2g5zrKDbFFTfB9ym3oKnEWk4ZKf
	 IwYJhh/HQAH97QcToYc2gLX/jkBE1PlNvjaFQXAAWF23GlCZdMbkPIVxo654IRw1pph05
	 /Bt/936Eef1CZiXy8lz1V/cOIq5I3O3rXhLlk2z/qD30N8+ItPEQ2ySGyJUAp0FVMzeBT
	 Y1p5o3kvTKk+fejDwAx5rsZn1Uf+VnB3ddu+/LLII3CQIL30dq1fhuxde3HnpnhiqxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975481;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=3R6UvoeFxFCY/Ej/MVx8n6FebbxoQvB9tmIs9Jv63a0=;
	b=NWXKCGuuntRj64FP94XG66dWKKp6+2XZBDs8K2N24cR+RNK9JOq2hbO0MJlL4VOeHrmM
	 0tv/z614hosGQUet4p1sxIHseJfsxR4NslrkrVNs1nKR+v7IcFbf3f581YBRW1AYsDaFt
	 9/X0JMswouwxMKIN2Z0iK4Iy4EGKO825pxpAYsu4p0AVfPlZs9qRQm10ZIMzvydHIcSNC
	 HsE+LwNGgLptv3vSpfKuAKEHh0A2C/YoQWIw1HEadO8GScNqC7JHeWbD5x+r7RQ0//qVW
	 Wg/1WnESJlUp6GpJFAtOS4REVWuwgVavSulzLi9yv0xl4GXS9DWQLy+ppG4H+j6t3Xw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=A4sAs1iZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4CC606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB4CC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=A4sAs1iZ
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6DcKpN1939300
	for <stable@vger.kernel.org>; Fri, 6 Nov 2026 09:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps01; bh=3R6UvoeFxFCY/Ej/MVx8n6Febbxo
	QvB9tmIs9Jv63a0=; b=A4sAs1iZWsz+Xe7qnrcwmJHgmp9ac6ZISDzRGcUUFnCN
	1ekY1+GBrHwdfo7muahziFncvTiS/aUUFn2amuxZiTcQZ8sUYT/X3aGJdFrVwJ7N
	ztRtKQb/UAIh0oaaVRq7EQGLhUIwUmhcnE3osWp+9zM6x8ml2TKjNmWQFhPkhzom
	rJVbJu82Q+D4UyVTl2gjddviOfvQPXT89j2egh3xYtXn8ZA+EIaEtbW8iKfV9PMf
	aS8+KV5ROBTDRUiw7HAIJki/hMzI9AeVYLas3NK/J9IpLwhgUEgzOQ/xfgSS+6t0
	jWMtkZ5osacwLaefXZggMa9T/on6PKYxogYgRcB2FA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hs3pbubj8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 06 Nov 2026 09:31:14 -0500 (EST)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b320a7aa32so6564207b3.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 06:31:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793975474; cv=none;
        d=google.com; s=arc-20260327;
        b=K01opr1w7EimRH4Se47nM12IVaby5PPqZKv1v8+nxzJNB1Pdhi/fyNDE+Iq8MPAy//
         gPOZnNx2e/oIdtgmwAHT2LlYt0gqdskTR6VA5ar6VNMueqvvXZj4KeeA4qkzt0v8B88l
         ASRgY7OVdhYQvpxXz+4iB/GvvIh2X7aTzs77Ch9JvppRsXd+UruGyYL/zWYDNVzBQXhY
         58J86GaQKSg2Et79w149NYPIwjj49kGp33L6AlhiUZ3n7CpltOdCtRwOthhl7XSQOr2H
         WY0eApj8Cr3Xf05xan7nZpEgg4zgGaCPqAD+UibpJ6WUufuRma0pb1vn2kkjhUGWboRr
         KRHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=3R6UvoeFxFCY/Ej/MVx8n6FebbxoQvB9tmIs9Jv63a0=;
        fh=VIDLMY9/m+Y9HZe9jhKVbbzvCA40MV9TRRctZ04qBJY=;
        b=LrbOMY94/GAYJ9wpVMdVdI1UZ7E35wptpyxXxNB2oNhzGGoJ7FkOeC81k20hrqxqc2
         b1OBuo5BOrP1HBnn2bQ7K9FwJbUHOIBMY7Mie5++HI7AA8mDKMltuNnw6fU4ynTTbrhI
         Y3db7MMPOwJd2B3wDjQuB5CuQspEUbaOrFKNKDinl8IKwnjtOGkl1zlR1f85j7EqZ7Pp
         CZG5IOtYQ+oWge2qiVG9EqMQzqiN/HtcwfhdUV82ttlSogxwTfCMnEKuMxvMN0foOohw
         AcCrNXLbBSUlFjcz4v2pL4MjC7UV/0Jd5abHb3iZYoxw5ql6e2rHXZQFNepIIpcZ+9Hf
         mG/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793975474; x=1794580274;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3R6UvoeFxFCY/Ej/MVx8n6FebbxoQvB9tmIs9Jv63a0=;
        b=Awt2vsPZuPrqHSBSILsA0/H6yGcIgqFCyiwrZ1LfnYsX875XKoqNb8e5RCuNYnvDB0
         MRy35AKA2QGbtHCzICI2y65ijHw4RfMv/zBmhbeK7OnE7Qqc0Szp8XgDlTWw2cw1jn0/
         +Dbq8+KfZZEXFqu7xJ5XvJBmC4JbL3kfK0bGFoTBGSd7MAlPUI1osxfPjTTZ/Ms9AONA
         zCEHnnDi1ON2E7k1/lOxkljr8uheAzXs8CIdmZDybQ5xubhn3NA2xenNGW+/vMEAQkNg
         dyM8sLWkpnCoBk9VJxbGHk/YR/uaNazRHJDvBK2p/eoY2L8btgV1MHHeiNy/+wyWVKjz
         9T/A==
X-Forwarded-Encrypted: i=1; AL+hErEAI5sli7rBjlYhkN3TqgTq2UPx1eZYEl/+eLODP+wHpqqvoiyYtCFzrSY5CPTY6ExnJe+JNuc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cIBMo1iTgnKJ5iQQb745DlKHJBH9muFZwiLZFNlnmTVwzrIwO
	Hj9dRJwQWg3Xg1zc7CYE7sXqmEZFxXmU+NMLD74nMBf4H1v7vWQ1E9vfWoaK6RZvhvThPI3XCKS
	ZUIAOvwwFO095LWYSYa68eNzLQy2vhcPTsGRK6tVChu236ds9txZ80p+9ZxkMjJYmgfFyti+Cs5
	bavw2LWWSEypOh60aqgqYjRvFdw8wCmvNInyQai4w=
X-Gm-Gg: AYBFou0BcSDb/TdW4k4ObIdF1z3Bfa5s32VERzPWQP8tnd8AYGlZd4VrDhUW09o3jZE
	qAqakI4PcdrOMxdg4/cWbeq1VrkgmyTwoTlG2eaTEbPu983Iy9loz1TbQH+goqQ1DWKeQeX/h7F
	s1drjnZDJS7Btqbx0Zi64cpivT6UAadnJRmXOU702wIcG3B1hGB8NwAyjUD2A0MQRU25MVVHw8Z
	cCG9F8PGa56v/hUJzMtUlHRJ2x/Zp6VsuT0EY3g8HWUsdcssMNX
X-Received: by 2002:a05:690c:8e0d:b0:8a4:aeb2:acfa with SMTP id 00721157ae682-8b341b2eb3fmr12003467b3.54.1793975474029;
        Fri, 06 Nov 2026 06:31:14 -0800 (PST)
X-Received: by 2002:a05:690c:8e0d:b0:8a4:aeb2:acfa with SMTP id
 00721157ae682-8b341b2eb3fmr12003307b3.54.1793975473710; Fri, 06 Nov 2026
 06:31:13 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-hyp-pool-and-map-v2-0-44a6ca90190b@cs.columbia.edu>
 <20261105-hyp-pool-and-map-v2-1-44a6ca90190b@cs.columbia.edu>
 <CA+EHjTxXpA6sCrSmwRJBA=YKGfNP4zs-THhheRHTaq2BfYY-Lw@mail.gmail.com> <au3eALuLVKZ1WXhp@google.com>
In-Reply-To: <au3eALuLVKZ1WXhp@google.com>
From: Xuheng Li <xuheng@cs.columbia.edu>
Date: Fri, 6 Nov 2026 14:31:02 +0000
X-Gm-Features: AclHuK-uSTIad-lvfbjp5wOphNsNX579YiHzXoYmvUtAiDrC6RcBzvikndjQbQU
Message-ID: <CAPOPQMDz32WrE8K0BDVLKbPc_Owx9izjQ+xPsJEJ2Cwy+BNi7Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] KVM: arm64: Compute hyp early-allocation and pool
 sizes in 64 bits
To: Mostafa Saleh <smostafa@google.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oupton@kernel.org>, Quentin Perret <qperret@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Joey Gouly <joey.gouly@arm.com>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: DJnCScddNqXyL8k-PoOOsN3aM1q4NKpz
X-Authority-Analysis: v=2.4 cv=Jt5kP84C c=1 sm=1 tr=0 ts=6aede4b2 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=qqJXGgh0nGIGBJ8XPqMA:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-ORIG-GUID: DJnCScddNqXyL8k-PoOOsN3aM1q4NKpz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NyBTYWx0ZWRfX9zL4lPC7weKz
 dLhHapucBMfwFuSwfFqpm9p8ADhA0VgdhDUco/eQ5oQ/BwDdBFdjwUs+rYEppD6j6FbixxIbCG8
 2Oxef9dK1EKeF5UsyuhQ4PsOHR70DR093hUyqNS0dEGSWqU8pxCjTUHreoQzUFwewJ/NRYUX3t3
 O6ovI7PtZEA1Pm91ftBx3D8hiLg37xaNdRfbdgL/Zw/pc5PFl1tpOoYHsgBOOyBNHzLKJI4DOVy
 QCEOevSaR9C3Rr5f4wlO2b9IlOaw6k2kaFZzbBKNvQy/ZxUDLHPMRO5NnnBfYTVpZHugov6I6fJ
 gKKe7CZoznEgIPxVjeWD81/xX1R3Bi6Bf9s+mnz2Ktd5wa6KAMExykhoa7D8Lh+89OMhUiz7O4N
 c/oTnsr7EA0LNyXwEo/Nrykuds1ledkN2IpAnz9sJCP5CNTboX806MdPPEsrkv+AEmlLu0FGTCO
 lmVOXWZJxfNTZMeeDvA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NyBTYWx0ZWRfX8gANrvAgsJKM
 iaXfn5aELSCjr228h1RqyhdlTbQZxmy/XFMHsNrZbSpFu2y+oEAPYf8MucA12ZG7Vhg4T09ig1n
 f9hNEgshWD2de7aybXnIHYpuQot4iPN0EtcUgPvbOpwL4K3kll6J
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11957
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=10 clxscore=1011 impostorscore=10 phishscore=0 bulkscore=10
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060057

Hi Mostafa, Fuad,

On Fri, Nov 06, 2026 at 02:02:40PM +0000, Mostafa Saleh wrote:
> I was preparing v3 anyway, I can post it today.

Thanks Mostafa, and thanks Fuad for the pointer and the correction.
I'll drop my patch 1 in favour of Mostafa's updated patch. Fuad's
description of what happens (pKVM init failing at the BUG_ON() in
hyp_set_page_refcounted() just below 2 TiB, and in hyp_back_vmemmap()
from 2 TiB up) is more accurate than mine, and the hyp vmemmap
overflows the same way. Mostafa, feel free to reuse any of my commit
message.

Thanks,
Xuheng
