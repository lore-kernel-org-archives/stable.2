Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC8F381B0F
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610886; cv=none; b=OwLLq/WfF0NwdpqC2YtgiiYlyoV5RJ7m4KlX1h80t2oWhixNCV93YJedvNyPXEotOZAgxvfViSUGMURnY4A1on9nvPvyp9/agg9R64T0Q802hui+DrHCQ2heDyJoyBbirYRUeJwLcKS0VulqrO2ECrVX3Gd2uZ4LwcKKn+59Mj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610886; c=relaxed/simple;
	bh=gWk0Tx1PpSkQ7SrrEuYSkz1J6FwF7G6dNVcAD48RLZU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sN8U7ym5gS3WqI5gXtEw2mHCNkHY2YtA31REgWVdo5bmWF7K2HV7Mw/EDtr5uSWCRhpFBiMGtqu5uEZ78hVXNQFYjRISIG6Dj48tetA/7Mk5/I2RiEvSx6i3hRmgpjbmP61Wk14p+d1GOSGU05siSCf5eO6loq0reYQjqMv8x4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2zplw0o; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2zplw0o"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47df6a5202bso7551f8f.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 08:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783610883; x=1784215683; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CHbf130yEa4XzJ/mR051Bre42Fa2Qf6EqrRM78ycRyA=;
        b=O2zplw0opYDrs9XEFRoiSuNPe4G5TK8RLytwyhRA38cvVChmfrlJZY2pXxvI8fMak6
         6tPINHKNR4Gp8RbzuXritr2f7L+hq/gWKOpaDDOFY9DaBlZE13EqgiFPhOODB6w6ZOJx
         3Jgx1boyO6psQzSsJoULhaUO85R9oo0Z4vV7UUo5FHbYExmbbf73KnbEp3SUUFH+YPWi
         v3BVKiRiYcxJPLe5ia4sp9vC788x8wq62cepvyeAXvulCpcr8G2czVPgYxcCbqrzIwCu
         6hXKYAMEMdpGeX+gdTG2HqshtrpnEb7MpXCon+blToWhbkX56zGRCu+WKuAqGLRpD1HR
         GSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783610883; x=1784215683;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CHbf130yEa4XzJ/mR051Bre42Fa2Qf6EqrRM78ycRyA=;
        b=Ja9IwTyG32qWMSdCmki9l79Wj/1LKTOCkXK3WtQ+Yg79RyTHBB+Occ0OL8wMs0aWX0
         PupHHkd9NP2ww+GbDE48NOqzdSOvN+6AqhSPF8Annee28PMMKOtEncexjWmjnulZlSy4
         i9dJRHYpObbGxMAU8ztgz1/InxQHcFFlUabyX/TI5bwPW/sXQgngXkDmfS0P92uQ5dsb
         xoz3SzufUW4Y/PDiMLMb1DYWRYkFHsLxDfS6DIolTQxH5MxofOoBFFcfzwRlN10BSZJk
         KUN0KCZZ5IEFgvpC0VvTrKmzJ2Tzz3g5gj30R4LQk3csrYY5gHwL0VRFODayq/UFawie
         WNjg==
X-Forwarded-Encrypted: i=1; AHgh+RooHLQWjULKNFWr/pnGp8JFRHRTnfli3dfa/2arVUJBNKx59qbSM/56d4Toe1f09WMUhbvD/Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq9dPau8BTbB9aFAwW8RudvCk6lt2gruz0kleYxaU/SzCFBmYb
	HML1wUjpP3kexkPvFS29rEw5+3MJcIPRF6fWo5NumEoLMlaHEBoMNVah
X-Gm-Gg: AfdE7cludc+yXeN3pAU4HMg+ErB764/RfIUHCXlQ6dp2954217UnbxibeGYtZbgyOWl
	bUQ8GOL2G6Fh4Nv8kH5UUbAidapnH5sPVg6XFtf5T+Kf+lj45lV6XHGR5uX6WboMnVL/RKtGyOv
	HRMf3yTUY5WkU3MEXCJIZl/MsUGfK7+q57snyosdLQGYb/D4lPmB9Z/GsvcYS7LESdRMENO0YTk
	bYB4/pb9abq/+UWFQtFqA0slGDPO2k8TGpCL674KuIymMvPRydOnGPAp+WOBLaVf219Ds2Auah4
	NQ8mV3Yond3YDiP+qKoccxl7TSQeN80OeoW+K9mDEBqoivWKjx1knBWq+vDabT0uS/6f9epev7d
	aLl1E9zgDA53b/53jPjfiv7DZYXrf8FpRu/hKxT6Z3NQx9jjVwC/gB6gTWb94pghl80/vamW33O
	g4D+p8usOesoBXSxmfjRPaCvs3jCkTTIfl25P54QtSqjSFIw==
X-Received: by 2002:a05:6000:18a3:b0:47d:ef25:ff3b with SMTP id ffacd0b85a97d-47df0812ef6mr8098275f8f.49.1783610882799;
        Thu, 09 Jul 2026 08:28:02 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ae44sm49942587f8f.23.2026.07.09.08.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:28:02 -0700 (PDT)
Date: Thu, 9 Jul 2026 16:27:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
Cc: "xuhaoyue1@hisilicon.com" <xuhaoyue1@hisilicon.com>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, Oleg Kazakov
 <Oleg.Kazakov@kaspersky.com>, Pavel Zhigulin
 <Pavel.Zhigulin@kaspersky.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, Wenpeng Liang <liangwenpeng@huawei.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Xi Wang
 <wangxi11@huawei.com>, Weihang Li <liweihang@huawei.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RDMA/hns: Fix arithmetic overflow in
 hns_roce_v2_set_hem()
Message-ID: <20260709162759.1d836699@pumpkin>
In-Reply-To: <24c0a3cf43074b37bb1c9c321a73f470@kaspersky.com>
References: <20260707140938.3106919-1-Alexander.Chesnokov@kaspersky.com>
	<20260708092146.3325855-1-Alexander.Chesnokov@kaspersky.com>
	<20260708181941.1ad1e112@pumpkin>
	<24c0a3cf43074b37bb1c9c321a73f470@kaspersky.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jul 2026 04:56:56 +0000
Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com> wrote:

> > When does the value overflow.
> > Yes, the expression can overflow and the result is assigned to a
> > 64bit variable, but I'd have testing this code would have showed
> > the problem. So what is the customer visible impact?  
> 
> You're right, there is no reachable overflow. In hns_roce_calc_hem_mhop()
> the 32-bit table_idx is split into base-chunk_ba_num digits i, j, k, and
> here they are recombined: i * chunk_ba_num + j equals table_idx /
> chunk_ba_num, and the full expression equals table_idx, which is u32.
> i is additionally bounded by ba_l0_num. So the arithmetic cannot exceed
> U32_MAX on any real input - there is no customer-visible impact, and the
> SVACE report is a false positive.
> 
> I'll drop the Fixes: and Cc: stable tags and resend as a standalone
> hardening/readability change. If you'd prefer to just drop it, that's
> fine too.

Best just dropped.

	David

> 
> -----Original Message-----
> From: David Laight <david.laight.linux@gmail.com> 
> Sent: Wednesday, July 8, 2026 8:20 PM
> To: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
> Cc: xuhaoyue1@hisilicon.com; lvc-project@linuxtesting.org; Oleg Kazakov <Oleg.Kazakov@kaspersky.com>; Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>; stable@vger.kernel.org; Wenpeng Liang <liangwenpeng@huawei.com>; Jason Gunthorpe <jgg@ziepe.ca>; Leon Romanovsky <leon@kernel.org>; Xi Wang <wangxi11@huawei.com>; Weihang Li <liweihang@huawei.com>; linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2] RDMA/hns: Fix arithmetic overflow in hns_roce_v2_set_hem()
> 
> Caution: This is an external email.
> 
> 
> 
> On Wed, 8 Jul 2026 12:21:46 +0300
> <Alexander.Chesnokov@kaspersky.com> wrote:
> 
> > From: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
> >
> > If hop_num is 2 or 1, then the expressions like i * chunk_ba_num + j 
> > are computed in 32-bit arithmetic before being assigned to a u64 index 
> > field, which can lead to overflow.  
> 
> When does the value overflow.
> Yes, the expression can overflow and the result is assigned to a 64bit variable, but I'd have testing this code would have showed the problem.
> 
> So what is the customer visible impact?
> 
>         David
> 
> >
> > Declare i, j and k as u64 so that the address index arithmetic is 
> > performed in 64-bit.
> >
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >
> > Fixes: a81fba28136d ("RDMA/hns: Configure BT BA and BT attribute for 
> > the contexts in hip08")
> > Cc: stable@vger.kernel.org
> > Suggested-by: David Laight <david.laight.linux@gmail.com>
> > Signed-off-by: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
> >
> > ---
> > Changes in v2:
> > - Instead of casting the operands to u64, declare i, j and k as u64
> >   so the index arithmetic is performed in 64-bit (David Laight).
> >
> > v1: 
> > https://lore.kernel.org/linux-rdma/20260707140938.3106919-1-Alexander.
> > Chesnokov@kaspersky.com/
> > ---
> >  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c 
> > b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > index 1c180a6b1c07..3469a9a68d3b 100644
> > --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > @@ -4238,7 +4238,7 @@ static int hns_roce_v2_set_hem(struct hns_roce_dev *hr_dev,
> >       struct hns_roce_hem_mhop mhop;
> >       struct hns_roce_hem *hem;
> >       unsigned long mhop_obj = obj;
> > -     int i, j, k;
> > +     u64 i, j, k;
> >       int ret = 0;
> >       u64 hem_idx = 0;
> >       u64 l1_idx = 0;  
> 

