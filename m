Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC478235C01
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786296816; cv=pass; b=exsgnZeYe9GjUWBstwvqRopSZzgs1AmgxWmz9udgJd2BLE4M0I8mBLOTKTWDltC6fASYeikoeeoABSc6H7tzzoV5nvw/BVMWeb2hOCb6zQ121afC+AOtL2z1ZQ2adZwA6DTVxggAYCmMLsuhEgdUViJETLQ8UAta9FJYoKBu/fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786296816; c=relaxed/simple;
	bh=mWlp5QNrExYXsGTZE+zqwgU6yWdZR31aZMXuOmCIjYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJAEl5Ne232jBlPEVUg6CDzi2LCcapwLKZiwben2xm1oPtSj1x1zUuzQyjgXKlc//CgNgR9RY9V3cb+9j4rBFDN2nOVCk5KxGd3Mx5LI/maVwMmcLRzYmXcPXmtXVd9ennPGxl7xngeyyk74cIUG82Li05RFbzavEZk8zRsgH+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dULiT3du; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dULiT3du"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7564b7a9490so2639549137.1
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 10:33:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786296814; cv=none;
        d=google.com; s=arc-20260327;
        b=lTFcKC2/QwebWmPJfPRa/A3DlEkqPG4NCTXnmvwXapQkNUTDq+/gw3WFkAxAFrMCiQ
         lvoz6sbJVSyNU6F8TIyJBXw23DDMPmVUSRblQenK2nEaYxxcWiJy1aDlbvQtjfXByl2X
         BrYq8PmZBmdepFQGIxy1/YcHRfC2gQg92IuNoLlmb2mAVLarDImAlI8LP4XI7QzfcMNU
         rMx9yTDhu+ar95AnPQH3hwjEKeeFWm/f/QsPuluyedSZhCq0AXMlFnxdPU6QZmrMOIMi
         zDOnzu+MdqBIA2oibt9iz17e0hF3Fdh543TplzcEju27lsUaK5ts5cW1hQdlqPc+0vv4
         htgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dnzny0f6nQDl/3k7kZ8Guokf4/cEXHhhetxys39MwOI=;
        fh=jrKTCcXGsDQBF3mNcwWdhdl4SXdSblKIW+mTLQwPgsA=;
        b=j3X4Cyrjt6Hc0xfD/oGqfvAR4bTWUZ1/ND8awPkwVkT3qCb0bCGAmKvl6s/wPQ/nfr
         axpvb+PAGtR5ZzFsWLj9Zn4N48oU9HErROQSvFJQ6QUVHagEGlj59sz0GKEwvKseTa6J
         KWAubNrDSMe5l5PbCnVNU8tsM9WLCwEQbGvC7EZxuM0P2sXXdMGdMfyQm9w8uSQMHKpT
         Kus6UpGkEMJe4CtiOrMnCogE9xTCwGtRB0EHMNR9/0IrB9woFhcakGmwlyOWj1xlJ8tW
         +2ZF/IlJTkXC0dslQWQLgRBBMUPRu2I1ER9eQPmcasy589lWu2DgBs6THKjWdzBAzNLh
         2nMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786296814; x=1786901614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dnzny0f6nQDl/3k7kZ8Guokf4/cEXHhhetxys39MwOI=;
        b=dULiT3du6l7QG6u93CVqzr3atDrTUbHxgFxv4W6Air89yJKedwPr8Qnn2H6/pXBz7V
         acMp6wqniUr3hHCZzVP6V+Lo/fqp1QvoKc4nbCCNAMuqgLMVt6+aIvaz4E2A5o3Q6MWd
         ZpD8wdzhlsGwyn4uk6Al2Xb2yLOz2T9DbZPhUluAQlVNI4CgC1Z6QgF2fFTnVKfM7rzL
         tFSWXCviQjI0DXCuSTGG8yQMebKacd+kOagRByuGX2SMj6R8/mxLXAtzLV5hylY3nrq3
         QVKIL+4QtlEromfPT2+AOR14kM/mvldmWMfBcuzhPy0tPyLSF2ue/6lhnPEqIYsNRMGm
         UB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786296814; x=1786901614;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dnzny0f6nQDl/3k7kZ8Guokf4/cEXHhhetxys39MwOI=;
        b=aF11DtSrO/QjI7VA6vAnvx7XB26FKRlreFr9ryo6B6yc5dSQNfhcsWvmA67J72a46j
         8z8x9KnO8oIYzm4OivKW3do0CCU6+nijmAcXeypL2SId/P5tDT45QSvQUecTebpQcAVK
         CJL2C4iqdbx0k8tSWYW5rrmKkjzgqe5oRFp7pDjiQhKdr8oORlW6RJlN+SZKD07a7X5I
         X41U3ZBJsHmy5UBaRz6mTrWSooNSTOyZw6sqbXDzA7DzsLNlUO9ef62jL/rtZsPaReNE
         m+nMZbKqSQbtpx/NcB0NFVi6O6nMmGW1kyP7/pcC8Oq58IEy1OgOgSxBxI4na+wqscGb
         aUdg==
X-Forwarded-Encrypted: i=1; AHgh+Rp9ViRObrtof66t13hQmy4YDvBHRlrlTtXEUeW1D906ns8G18dv/MM35rgWp2SE+yndPCaImtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLL/aPc6JeRG5edOxNwBfignxgJKN+pXml5759jggframhAkGv
	cM3ZL62OdUqiT54qhTBepUXo0ofOoEZQq4SCnRhv05Y/qlAjkMjnSqpvBhDF12qd8ewY/HQ/+Eo
	bBF2MkLh70Ci6cjonXafB/m/QLmFw46I=
X-Gm-Gg: AR+sD137DVAPDoOzLW/wKkEu/T2GMc/d1OtkFXx80rjtqXa/Iqeiw1u7bHux/FuJOAj
	ky0hqpkSikFr0XzWZv8mri4y1oXqHBxt6aN1zlhvcOIyvnucIPcez+h3VxaKlxnR+msPz+OMehY
	5i+eIOGhkohbgDsp2LFIh9pg3qLdde272FdKx7qfucbf3ph0B4kYT6yDaUY5iv/NHq3iBmMNi+p
	Fd7kTYOhAiT50TQttXpPO0NkzNTfGAWkypAZMX71QBLWtU7mOBCOcyinFWrwg8vnAwbEDe8vtTx
	D6f9quCf55mTdLrE5j5Lzk1u+aE5AfEzLeB939MtCdpMB6UclkAZxTlf46vYHpizHjNL3AVcLYP
	pYds=
X-Received: by 2002:a05:6102:855a:10b0:747:560c:e7e0 with SMTP id
 ada2fe7eead31-7652017a8e8mr760293137.1.1786296813739; Sun, 09 Aug 2026
 10:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727014745.1304657-1-zhanxusheng1024@gmail.com>
 <CAOi1vP-Ba2=Gd3_wtH0g9yfqB6xJVstjarsmUhXj7WGXedqGBQ@mail.gmail.com> <CAKPOu+8Y35cfhz5gqus18-HPLoVMiSWF7cVXVbyn6GmdJA3Z6g@mail.gmail.com>
In-Reply-To: <CAKPOu+8Y35cfhz5gqus18-HPLoVMiSWF7cVXVbyn6GmdJA3Z6g@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Sun, 9 Aug 2026 19:33:20 +0200
X-Gm-Features: AUfX_mwnwy3r9fgavh_y4tM6O72D9MJwvIgSBEzeWm66BW3l5prqagQEgEI0_Kw
Message-ID: <CAOi1vP_oJC73d48w_qJaxtxrX-mVMYip3-rg-iYoHwHn6Tz-FQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: use the mount idmap for the owner checks in the
 SET_LAYOUT ioctls
To: Xiubo Li <xiubo.li@clyso.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 8:31=E2=80=AFAM Max Kellermann <max.kellermann@ionos=
.com> wrote:
>
> On Tue, Jul 28, 2026 at 1:31=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com>=
 wrote:
> > Was there any specific reason you used nop_mnt_idmap for these checks?
>
> No, I copied that check from another filesystem, probably ext2. I had
> no idea what this parameter means (and I have never used idmappings).
> I guess the amended parameter in this patch is correct.

Hi Xiubo,

You reviewed Max's "ceph: add owner/capability checks for
CEPH_IOC_SET_LAYOUT*" patch.  Would you be able to review this fixup as
well?

Thanks,

                Ilya
