Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794298231;
	b=RDxyRLva4nk+tLWfWBXInaW+Sowe7kKK/KsqXbnzXzF3ZLotSc8MvKtc5tvHIb/Q94u9
	 XQQp3ByLhDPMWfaSX4RZ1CDhjVSNGe7wzO4HemD/OIkUgdpKG4eii6T8L0x49/zP/pfes
	 iVEz1Hm9z/868D7mp97lMvPmPNOx3wt2ngHfCUYvWvgXSirYLFSRCdMKD8mqOIzGlA8AW
	 5tSpTyPA6a684sFX4Eh5gGpt1fiMYA4de9PYy4D+pIrkZb2oHAHyiJpMOjdh0tHHloZeu
	 OfCP191f+og5MnVQlIS3m2oDoNWNLlhJZRDMuaWmn7ByasZdjMQBHKurFPbd7qwMjsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794298231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=0M0PuSsNVc486tqkV94uKeE4Gx/HBPT2tl+WhPW8wJ8=;
	b=uOGl0hsnNkP5MsF8cELDh8rFUVI78Z4X/uhYtrTi3gjKTvaZ0EutQsoHlmcPpK6b9uVC
	 EHXRCFKKPEEPtdcuR8hU/5nOTJy6JVXpV7G3w50HNMBSP/U5vJjb9aXnACE68OuuOJDVB
	 rGtzjZI0zwbRNCoK2cxKGXm7ridaupZ8U3feh/FnGXuubouOoqZ8Zno1Z6aHnLnZBkQwj
	 NJ5eMROEqYy0kMK0ymslXyqAb76RuVBkgauR8FosLB6Bk34geFAax3yRK9763NxAb5Mpg
	 NsK1sRB/+cd/f3MnXpINGFkuQXVm4hk7LcpPfN6WfqLAhO+S29tbQI8gdXIMYCrKltQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="s/LKf3p1";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E442F606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 08:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E442F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s/LKf3p1
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b7221c0f2cso638296a12.3
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 00:10:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794298229; cv=none;
        d=google.com; s=arc-20260327;
        b=n5pHIDfT5mu+MEqf5lCJHKYA3TfJ7uPNmmUfE091ofN9+g7ea8f3qUsduGEvuM3SCi
         bD2Bdvcp85bafkU+otwbEq74Pz845n2h/pL1wG2u0Mz0LYQNAvTXKlA+9CWRitmFNWJv
         1WJ5DU7GaGvjgS2Lfj5tId7tI0Du53hWQQAcfOU9oqg7chYzlpSVLKKWJgll2jip3xJA
         iozXuEVhYGtvrnL0AsEuSZia0VlK0zm2KeXullc4t9Ae9pcFZclC+mpB6b6xfdDASST8
         nFB/dKxXHsFOpCcf9/EK2ba/P9Jv4vXcoAUn1lPwwFwYmvhqraAqWIt0oXyQbPK9ExX3
         dXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0M0PuSsNVc486tqkV94uKeE4Gx/HBPT2tl+WhPW8wJ8=;
        fh=a3UD+BIoQvYDhcpihvLZI5xHdB6cT8fVj6vKTy+WTz8=;
        b=XFUwYIgh/RvDPCFULX/85O8arSpQIxDtCRPHZWA064Uib6o2rh3v4iVKT5G3/go5da
         EwZRyRWUWp1JHlOCNteHHbPvxm6nYnXy6PoImazeiQ2Kzf4WqYXIUYT7j5ozonx+piM0
         QoNM6oD5+1fYb7Oz8vjan8KDx6hFcqyfkWGBPIAighTBUipnbAfDrhzzjQfYnXge1/3/
         tJqJDuZQrtVmN0WuiTy9maU4uPw/mClKBt4yR9ubu1hUphY+BVjLGNaSmc4zo2IXwpmz
         mGr3EmJhXlWrTxdcIiUo9HqvkgZPiIkZbTZOkcqJMGjUsTr+PpEmwzpGOoL8zgLQBiJH
         cF0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794298229; x=1794903029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0M0PuSsNVc486tqkV94uKeE4Gx/HBPT2tl+WhPW8wJ8=;
        b=s/LKf3p12NuUZ9d7BzLTJGaea+p/WDthcGef5Caeu2FMQhJ/L/rnRru4iuiHc83jWS
         XoZMbaJHUldv5njJLpGnmhd1eMon3JM7ocHNqPP5vwqdU+oVwxMReiPjceroh+rLS3UC
         3Hziluq22KFKVmCACdnXHNsrfQbBXCd4Sd2qVa5DcDyIgm3FXsWJmiWoee756GbIbHai
         EVhe9YwanynH/BB5lriCUHI/yVXqmelxiezL9M2IwCVqA3NRI4F1iTQ0HSanxoKSENIO
         QapXbvy0w8PWs87s+l5NNk577DUjeibKvnfrp25lifS9NYxCt5fnKBNNtZ72/RtldYSO
         TQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794298229; x=1794903029;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0M0PuSsNVc486tqkV94uKeE4Gx/HBPT2tl+WhPW8wJ8=;
        b=pjgZIeQ0KldLXEt8Mf+ohsMDc2cuWKobUNRUOQxcJ0c+L9gszsdXTvkJTFV1NCrKNP
         d4r8E/RGlKI6g66IQtyA2Hg2Y3dXC+tHoyyGwYnhUi0s4mgF/JZ9NLgozGCHCpSLm1Gh
         Hci4VU0Qxhq/zXe4Zx4iTSVu4nMoQkQh6K65vfkRUBXuSs+rJtWDeTgrbz997pfxxLC+
         XZiavf38fltijeY1HXkSL14KO0zihnlEbM/u2ate6lweGE9B+VIIS9KkOKRO0Sqh2yeI
         NISYFgrdTIfzDTn9q9rQwG1/S2ZarVvCW5mZZp/Jl7dtPLpKRQfpLImyvUKrXNY8/Ow5
         dvyQ==
X-Gm-Message-State: APuU4Z9QbERwpL0vei49lHSC91Z/uXaFUpmXBXI80oxEFaQ2sqqWvLvT
	M1D5pEtCtnuTbV8XqMVL1bvlMzlG2P/mjkxln6Q4Gil0EMwwuCxaACoy+L9kVBiaNDIetOCy3fX
	8K5j2e1oyrkr2lRPg0dLr7Oou+hzKmV4=
X-Gm-Gg: AYBFou3/CQ6WD2NuAU5MI/Cr53oIk5eC617D3L/Q13HHJzrAjI2ihPYA0weJcoJKW79
	S/wsIhiOVD53f0BasErRhDOQxF7NRygrYuNKAzfaJ7zT8M2lGDOPfFCjHZDgjssh3eAfWC74gWN
	cvciGzeEJoE9OpBFgAUfb2GrKKPKShD2Gwi0PAg9s6yI/KM50fnPywxmo3gHb5MnvEwVJcnAUT9
	Oo9f4QEgyiiC7V6VfVWjnZuVC6W+XsX/8GlrO3vsYwr5mgpo/WD5w/1HF4JyKFflCMke9rpXINN
	OnvRRlyogsyhDyTAlqFgQkZFiYDB9tgUpd5J24joeyMD7fJWZc9ITYXbjKzepNEVExm1MSvbCOy
	zCh52ejzC9veIw9vjlkWEDETdfvQKVtgTHOn89gK/DMqhSEQEbUTPmuyx5AMSbPKqELtH0g==
X-Received: by 2002:a05:6402:322a:b0:6ab:6e:a8e4 with SMTP id
 4fb4d7f45d1cf-6b756b1fb47mr1380621a12.44.1794298228945; Tue, 10 Nov 2026
 00:10:28 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107052836-failed-6.6-669bb5af15d4@kernel.org> <20261110032904.180619-1-sashal@kernel.org>
In-Reply-To: <20261110032904.180619-1-sashal@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 10 Nov 2026 09:10:17 +0100
X-Gm-Features: AclHuK_Gseu2d8mFRplEiE7W-YAYS549Mvqve13geMWX-6AkPSpgXp-FZ2qzpuM
Message-ID: <CAOQ4uxi7xkQiYtjQNuso0MC6KGGpwGbd+xST5NQ_aYOtaoAixg@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] fs: make sure to call fsnotify_inoderemove() only
 once when inode is dead
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Daehyeon Ko <4ncienth@gmail.com>, Jan Kara <jack@suse.cz>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 4:29=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Amir Goldstein <amir73il@gmail.com>
>
> [ Upstream commit 669bb5af15d41a21359d00a441490f87a88eb52a ]
>
> Daehyeon reported a race wherein fsnotify_removeinode() can be called
> when inode still has a live alias.  This can lead to several undesired
> outcomes such as crashes in fsnotify code or avoidance of inode mark
> notifications.
>
> Check that inode is really "dead", meaning no nlink and no more aliases
> before calling fsnotify_inoderemove() for final cleanup of inode marks.
> Also do not allow open_by_handle() to add new aliases to a "dead" inode.
>
> Ideally, we'd call fsnotify_inoderemove() once last inode reference is
> dropped to make things simpler. Alas fsnotify inode marks currently hold
> inode references and thus this doesn't work. Once we teach fsnotify to
> avoid holding inode references, these games with dead inodes can go as
> well.
>
> Reported-and-tested-by: Daehyeon Ko <4ncienth@gmail.com>
> Closes: https://lore.kernel.org/linux-fsdevel/20260827045007.3831259-1-4n=
cienth@gmail.com/
> CC: stable@vger.kernel.org
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> Link: https://patch.msgid.link/20260902164924.1333135-2-jack@suse.cz
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> [ sashal: Moved the second inode-dead check into the existing __d_instant=
iate_anon() helper to accommodate separate alias instantiation. ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sasha,

Please drop this patch from all stable kernels or apply only together
with the followup fix.

This commit introduces a regression which was fixed in upstream
shortly after:

commit a522dd871024a0f065bfa7638afdb929607f58fc
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Fri Oct 30 16:55:52 2026 +0100

    fs: don't fail __d_obtain_alias() for unlinked inodes
...
    Christian Brauner <brauner@kernel.org> says:

    Amir's v3 replaced 669bb5af15d4 as a whole. I turned it into an
    incremental fix on top of mainline and wrote a new commit message.
    Jan's Reviewed-by was given on v3 and the resulting code is identical.

    Fixes: 669bb5af15d4 ("fs: make sure to call fsnotify_inoderemove()
only once when inode is dead")
    Cc: stable@vger.kernel.org
    Reported-by: Daehyeon Ko <4ncienth@gmail.com>
    Signed-off-by: Amir Goldstein <amir73il@gmail.com>
    Link: https://patch.msgid.link/CAOQ4uxg7Qt436SiKhKEJKOjtCjeB_XyTjazYF7H=
MyQAGGcgx2A@mail.gmail.com
    Reviewed-by: Jan Kara <jack@suse.cz>
    Link: https://patch.msgid.link/20261030-work-dcache-obtain_alias-v1-1-a=
1f7e44536d2@kernel.org
    Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

I don't like the idea of selecting patches to stable which already have fix=
es
themselves without applying the fixes of fixes together.

Please instruct your bots not to do that (at least for my subsystems)
because the risk outweighs the benefits IMO for the general case.
If bots are able to apply the fix and not able to apply the fixes to fix
along with them this requires maintainer intervention.

Sure obviously often fixes that hit stable will need fixes of their own
and often those fixes of fixes are not known at the time of applying the
fixes to stable.

But this is not the case here, the fixes to fixes followed to mainline very
shortly after the fixes and are available for your bots to detect and exami=
ne.

Thanks,
Amir.
