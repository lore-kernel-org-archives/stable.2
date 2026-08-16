Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C562E92B3
	for <stable@vger.kernel.org>; Sun, 16 Aug 2026 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786907291; cv=pass; b=drtF2H6j0WTvikAbpQg/qtIdmcmA0SugwhfWbx1W7VIjtUY9XFNdM7biNpnc88iGF3uGEsVs8yEahF/ub4MgkTHX0XHdQN+EtBfiQbOwraeSLXH3sDasRlNn83M1+ytz1BeOeKgPtvtJheeVEtg97c1TxQSQhuSCWAFUxlXXTMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786907291; c=relaxed/simple;
	bh=XwkAtK8mb547dOop0lL275XKuuWVoIn8HVsM4LiJAaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lkd2CDW5MJHq7CS4hHHjjBwIWOOBiP9Ss9I2XlZj3uvlteMV7n7f0oLJsHEReZ041ru5Cxv1vDExVBxxUnuDSeltaXT7up7rdEqkcWSoDenMy2VBEGHzpu4k5hIVcY8SMldkABRm7fjwBFQsizdB7wO083afYD1UV5/xDC6vLn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdLEYJ9h; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdLEYJ9h"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a1542cdb53so2884634a12.2
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 12:08:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786907288; cv=none;
        d=google.com; s=arc-20260327;
        b=RjYdlq0k5/Q11BP6JhEtK8/Zs2ZdftqjsPVj1/5TOOT+hX064euwyANq8M+kWaVRwi
         NQ5vBdDU2DS1JB4Cucl8wkKpbD8zWb/remmii+/ghQcU+enOhypMPhNKZed1pvAI7ZI/
         684R+Zhh933I+HvqAUiZNZUMreY/T/3oGNjvoZjzMLjqKStdEDEewPes2RgGtTu0dOgD
         3VeCdggvpaI9xy+bHZCOd0WHq5FmBEc9yVJhqV09F5dLFyu0vcmtJb/FAPohJgBBJeuM
         LbtjKHVr0/AojwIrGpCtdRD+DlaImqLtTsNFIm5iO5NYXMk8R5Lsid6fPka5kym8vdsK
         33XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MJpiUaeSmSukMEiVdIJ7E+Eb4oTrVCSTLcJCR2loI3k=;
        fh=Fre6VZFaO7pRLUUDGgmKc7Kc+SdfznlgsAllThRu5Bs=;
        b=LdG/DoEqvreulGxy7lNY/HQPSRjsWKgNaBdPMK/Hu/qs4bTe+HTQcRl2JcE3MDzdE7
         4FcKooI3HtnVXlkM7McSHtpxgjm5rwwOyrnv8g3oOynSny0tH7ZKCNrmFFInYZ/F2+gG
         xb77p3RtApsGbp0ExVOChC4wsAZBcopsNxlt20ZNtgIdPaLZINmYHvU5n+BBIJ27duQT
         ETsZLZfyxKna3WH2jiHbOgFcGIyUb2rWkiKQwmEDw1fSuyFpbasaggh8l2gpoh5CE6iL
         NJzH1iBCQED98OorZf8qzUGoQ+XmEeDZ8inPmiS0/J0oGUQG7qiaVqLhSrQ23PlRIO6g
         VStA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786907288; x=1787512088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MJpiUaeSmSukMEiVdIJ7E+Eb4oTrVCSTLcJCR2loI3k=;
        b=fdLEYJ9htxaxpCOJ3dSL8DBNnSf6qaKlUBDuHL5rEfpYkHVQvWRCNxHeWB+xhDRNAY
         C5jcU5shhexTZsV55yJl/OfPh0H2Qktrrlh4X0KkGEoQeOqIeaQhifI20AbB7U7gtUgS
         1kVuyvd/SH22T6tV5Iy7wqiwJHVNAbskrlltkDAPC1xy4z3aMuTg0JaGJkBxDAKcdtVy
         n6RNOqWf/ruVkoeMyLwIrmmutAh3Lu7iUWaAEJf/0eQJJHPfHYXMjFjSZvayY3TSbu7y
         tbrDqbBiSIxjqOeiv23AqxS+KEqOMJvdZ3b9w+zeDyvv6NfhsxBtCraNrbT7Z+ZMiTot
         t3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786907288; x=1787512088;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MJpiUaeSmSukMEiVdIJ7E+Eb4oTrVCSTLcJCR2loI3k=;
        b=MJNpAhu2v4ElW/YdFZiiUbS5Nzk20EOYZm6nA6SjqKUkU5QzVFyVRZ/pd96cBE22KD
         SV28ox5nrbaqCNQuxHkWJdOU0AmnPddsX1SlYvPbDoMrum2McVN45jQZkb4lrdw9OMoT
         vbAtXO02FUFbcIkFOpR76G7JiBKNFMjI/rv5RudzSpV5MwjqUoiHrziuWSJoejHFYiRb
         ND9nrzYTOzj76517z5dlVtIKWk2NX563VAKVUfsdHCJs4Qg7ZWmbEOPOfLHxR5tYaKMq
         JRqs0uh5GGeoQvFz6v8LMYjXJjsb28AHPUUC8LNWryHyFZM1xtDZNS8KxmtBXc1wGb87
         YwQQ==
X-Forwarded-Encrypted: i=1; AHgh+RqIAhytnZjAgMLdbqRLAJeDm/PCRzN6UEl+i595QufRmS8Sfht5S3i5EGM0IA1CKoAS8gLutXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY/apqctGggUa1C0XOXRr9Sw5TCr3ACwR5S1oEz/2MRCUX38iN
	lvs14LOjDSB/HFgu8VRtTF2ZiJNX9/cbIrTF8FxGOUC8fluYWj7VAgm4sWbGTN/sqW0Olu7PVbc
	5PgQCFgeK8nx+SIeT1b/SCl2ZNRF+QCQmkDCUndo=
X-Gm-Gg: AR+sD100ZQ9PWyv5CbIqJxd2Tfi9uLhnVYOO93inlqmppIoBii8BLBSO4qxPaiZX6Ke
	xUr6BY31OGlGcArNHibvmMitmbQjGBWWTxw+3+elmt6xsS593iJkOtHCAiJvoFH7D2Oxxzi9czK
	rDBF/toWF0McmOubgQb9fVzwGBgxZeNO/U0LPV0VBNQLNBfySAnGBkYFwbPUDV+JqhXXshRHXTk
	WXr7rGN1HfYoOWrPb0l1F/rsSAWWijOz7TvvyJHLcyyrkXY+6TMcQ5QXQSJtO6NXT3pJ4CQ852x
	RsR7TSSAeSsbkA0XofLw5trm6angqBnt4SekNXBhOcfy
X-Received: by 2002:a05:6402:530b:b0:6a0:567c:c2fe with SMTP id
 4fb4d7f45d1cf-6a38a9a323dmr9308591a12.20.1786907288432; Sun, 16 Aug 2026
 12:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814160954.2839507-1-coshi036@gmail.com> <an9sbzM52QqKdQuP@kbusch-mbp>
In-Reply-To: <an9sbzM52QqKdQuP@kbusch-mbp>
From: Chris S <coshi036@gmail.com>
Date: Sun, 16 Aug 2026 15:07:57 -0400
X-Gm-Features: AcwNN1UGmJA_m0q1P9tSBlDs0Z5V6pFvjJicpL-HIgO9xLhhaYThNptM0VyB1C8
Message-ID: <CACd_6n1d9kdEYARkmf6bRzbt5SXwmf-8jk_Dd-xJ0gyQ1TcMMQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: reject zoned namespaces whose zone info query failed
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, joshi.k@samsung.com, 
	weizhu@fiu.edu, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 3:28=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Fri, Aug 14, 2026 at 12:09:54PM -0400, Chao Shi wrote:
> > Before commit c85c9ab926a5 ("nvme: split nvme_update_zone_info") the
> > caller tested "if (ret)" and bailed out on any non-zero return.  Restor=
e
> > that behaviour.
>
> I think the namespace is generally left up on purpose for controller
> reported errors so that we have a device handle for admin debugging
> purposes.
>
> Can you just skip the zone limits update when you have a bad response?
> Something like:
>
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2457,7 +2457,8 @@ static int nvme_update_ns_info_block(struct nvme_ns=
 *ns,
>                 capacity =3D 0;
>
>         if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> -           ns->head->ids.csi =3D=3D NVME_CSI_ZNS)
> +           ns->head->ids.csi =3D=3D NVME_CSI_ZNS &&
> +           zi.max_open_zones)
>                 nvme_update_zone_info(ns, &lim, &zi);
>
>         if ((ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT) && !info->no_vwc)

Thanks -- keeping the namespace around is clearly the right, I
had not considered the admin handle.  v2 does that.

I did not use zi.max_open_zones as the condition though, because 0 is a
legal value there.  MOR and MAR are 0's based and FFFFFFFFh means "no
limit", so nvme_query_zone_info() does:

zi->max_open_zones =3D le32_to_cpu(id->mor) + 1;

which deliberately wraps FFFFFFFFh to 0, matching the block layer where
0 also means "no limit" -- blk_validate_zoned_limits() tests
"if (lim->max_active_zones && ...)" for exactly that reason.  So a
healthy device that reports no open resource limit has
zi.max_open_zones =3D=3D 0, and gating on it would leave that device's
namespace unzoned.  QEMU hits this with its defaults: hw/nvme/ns.c has

id_ns_z->mor =3D cpu_to_le32(ns->params.max_open_zones - 1);

and zoned.max_open_zones defaults to 0.

zi.zone_size does not have that ambiguity.  Every path in
nvme_query_zone_info() that returns a positive status returns before
zone_size is assigned, and once it is assigned the only remaining
failure is -ENODEV, which the caller already handles.  A successful
query therefore always leaves it a non-zero power of two.  So v2 is:

if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
   ns->head->ids.csi =3D=3D NVME_CSI_ZNS && zi.zone_size)
nvme_update_zone_info(ns, &lim, &zi);

One open question in v2: on a first scan the namespace now comes up as
a non-zoned block device.  Setting capacity =3D 0 there as well would
match what this function already does for nvme_update_disk_info() and
nvme_init_integrity() failures, and would still keep the handle.  I
left it out to keep the change minimal -- happy to add it if you would
rather have it.

Sending v2 now.

Thanks,
Chao
