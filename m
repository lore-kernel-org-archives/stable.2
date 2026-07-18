Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A2F38BF7A
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784377248; cv=pass; b=sYkdC8+vxnP5iy3DMQOwiog5wSN/blJzMY7+fEpCog5qp0s51jdCm7K7PJ7GXvNqY57/B7Mz7TYfDNvyjxUiFpQ18pWOUB64KENbhauWbFT7fNSOwE6mDf7/u3YgVoAXPkGq3CqW+w+HK0Vc2RlWpn9uK/nU8ay/97YcEYSXAPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784377248; c=relaxed/simple;
	bh=SawkhVKH+C/u+ep19YJdq5ABv7YXpG25grrv5K0m2hg=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTcY1qJEmvDpB2XLpm+9yBEb9OWLpNYXMe+jL4XjBk4EtDRE2glhxUmnS5Q0KMICcmBGYmafD+QhV/ojprB9E6QCtaBtJNVh22PkIgmgtsWu1YSKxAA/uhqvLPH6YczbHiDAy6/u7awYXvz6J2qsI4Wg4QO0uKrsCzi4T9ZUyFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rK8tdRhB; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rK8tdRhB"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-667b0ced2d3so9975431d50.2
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 05:20:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784377245; cv=none;
        d=google.com; s=arc-20260327;
        b=QaP8nGQ8gmTDzVF0sTMmMKf/r5y/XKUf08i7LdAOZHA+0o+gSgr11Yvbx/yZJlQ4hZ
         KfClWvsxcQO9DEla407uSVNW8QWpvUXOkWmWv216Viv79zeNvphYBq9/AUDkfhgPU5Et
         t53eK4K43V7ucNv2NCpcm5ugL3bb3dt5hXd/SC2Y1wwEThHBO0+RyOl9xYLPnPSTbWxr
         6RR0gnUmPhpssf+yqQTk2CLdBRlPlO3c1Rv5qTCmpbd3RewtqJRC9HzsDATkg/5u09mJ
         HJHc7WV0PZhh58w+gHBMWuEeSJpSl/LjA9MFFR9ypdhMxOm++/5h9uy5JY2G3G4fqEou
         azeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=SawkhVKH+C/u+ep19YJdq5ABv7YXpG25grrv5K0m2hg=;
        fh=Y1bIraur+asCZ0GNgFChTyTPasz4nyskxa3GXPhEi5s=;
        b=IB0RsJ/SkhvxRgEQVYLI/rRo+ZX+nnpcOpqstJseFKrSGdmqXlTAuumluyzX8yG/TT
         t7rKl0l/AEWkINjStq/UZwlwiBk+r2LBzaERcVpOBplx7jhVJ1IvlKMII+2O3X0InlR/
         gr/RT2mXRK6fhhz5Vs8Wt0rB4AoAvFqipj0BI+LSsGf6wxcAfSiEsg8LutJKrpeiPDcq
         xWwsTGH0cSHDoUBjsqN2Hxc09pxVa8i/VJUxtT8N9XmlZ7j6LMO9pUzQ/WweRz9XllLd
         J8VNSMLmFVYwrFUDKZfuxQmZ07cRQK+DEXe2wEaLwmo996Smg6jatWyWkHtyBtPj4V/A
         v2rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784377245; x=1784982045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SawkhVKH+C/u+ep19YJdq5ABv7YXpG25grrv5K0m2hg=;
        b=rK8tdRhBCZGmCjFwHJAZrSAy/R5CWqCNYAHdAaTwvkQP/6RcRYWBprl1VqbNVaUUsS
         jxqchWrCWLdDgbeqautYrKdufPK18YjfO8UYbtQZ4HcVlV8xF5hmCuCryfHh1UCPzCcg
         I1GvuhDz4SBh42AXie4UGRD/insCGoJSLeqfHGLKZk9UkaKgiKBL0BQTUEkl1+cDsfN5
         M61/XKoxywFgAS+dCRlN+namyLs5vQeqhIvGVC/N7Mt9iz8LdHUyS47HjBm+nkWt6M9K
         RRUY7VwpzgGIDXAFj40wJTJDwVLEX22hvA+QrCS5q3xSSxwNcnXQbJAOLV9fVgibWzqN
         Q7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784377245; x=1784982045;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SawkhVKH+C/u+ep19YJdq5ABv7YXpG25grrv5K0m2hg=;
        b=na8MxxF+/I0tt10YZ62h/63/vyk2Ul3MCi2PEeobYbQNJYeVd91ncl5WxG/uiuoPPm
         TRdm4e6Atymitkyfs6zIM3glAwXHAjV2fdYEhZsWjCKZmCP/0pUoHavGw1fS/cgAJ7ry
         WvMEanqaiZYiIW7ozgFqoXVjeBE+Ux/cfx4hqD5MPw0f7CNcRx/VnHUj9P8mfaa4gfNq
         Uy7Kg1j3wyGbGh9ryOfhjA8z/5Ee0PAbVJ55adwJ0QncK5aJ9Ou+483b8Ts4hcDdJV6t
         4QQX8Q49Yx3fSNxpS3QWZv+kXdjXYHmln27GsMW21d4kUFhxVFlE8k0YTsuxeYHj5cL5
         rdPA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8jg0hXRnj0Ov8bHboqC3GCZ4/isGqNZXGlsRRZiRCj7SE+pDaxfar5e3UTr2WVOU7lZub9Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5LgHs3ANbI8sgl4BDOoGc9tbIo9kUs0paJQT5qCh8sAqS63uz
	iAv2lQTh8QswCtbtVKgod/LmtPTZJsKH2CDYxyZjcwOiP0g4hbyft8ob99JsruUBYo3BTJs0Xna
	rGts7rAF97kSx/ordp7VN1JsBVUSOphM=
X-Gm-Gg: AfdE7ckby/F8uJUso7zvSLwhccbE7AXDdGdF5X9SSrKZ6roUL+56w7UO93vRUoqXmc0
	mvQOcit3/U5mnxRV8vDudy66T08B7yAuFXaEb1QySesjYhqRqdOQyHCLww9AEIDk9svDLZYAyaK
	ft1NYgv9HtFMuiFVvQP4Yj2dYHWTCrjVXF0jzU8s2/OA2XmuwrYeC2klVWBeN0+0S/3WSuoEdcq
	1xYCIW47N4Gi2mCTeRj0NPcA+6mmCAn4eXex+NPlModX+lnWxS+Qc6EeDN8TQ==
X-Received: by 2002:a05:690e:43c2:b0:667:c01a:4ac5 with SMTP id
 956f58d0204a3-6683bb0c3b6mr1363452d50.38.1784377245608; Sat, 18 Jul 2026
 05:20:45 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 18 Jul 2026 07:20:44 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 18 Jul 2026 07:20:44 -0500
In-Reply-To: <87h5m2g70l.fsf@bootlin.com>
References: <20260709221858.158063-1-devnexen@gmail.com> <87h5m2g70l.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Sat, 18 Jul 2026 07:20:44 -0500
X-Gm-Features: AUfX_mx-LxGT1icCnBbh0h4QeQdJg-IRuavKQPCspOdeBSsqwocWMxKfeD5I5ro
Message-ID: <CAMuQ4bVWGV8Qz7LM1RCVhXJGRV0KVPFXvvhshDEijkv=+aq7Yg@mail.gmail.com>
Subject: Re: [PATCH] ieee802154: hwsim: serialize pib updates to fix double-free
To: miquel.raynal@bootlin.com, devnexen@gmail.com
Cc: alex.aring@gmail.com, stable@vger.kernel.org, 
	syzbot+60332fd095f8bb2946ad@syzkaller.appspotmail.com, 
	stefan@datenfreihafen.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes. I'll send v2 of my teardown patch with rcu_access_pointer(). It
is separate from David's patch: mine moves the final PIB free after
unregister, while David's serializes concurrent runtime PIB
replacements. I don't think his patch is superseded by mine.

Thanks,
Yousef

On Mon, 13 Jul 2026 18:59:38 +0200, Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> Hello David,
>
> On 09/07/2026 at 23:18:58 +01, David Carlier <devnexen@gmail.com> wrote:
>
> > hwsim_update_pib() does an unserialized read-swap-free of phy->pib:
> >
> > pib_old =3D rtnl_dereference(phy->pib);
> > ...
> > rcu_assign_pointer(phy->pib, pib);
> > kfree_rcu(pib_old, rcu);
> >
> > It assumes the RTNL is held, but ->set_channel is not always called
> > under it: the mac802154 scan worker changes channels via
> > drv_set_channel() without the RTNL. Such an update can race an
> > RTNL-held one on the same phy; both read the same pib_old and both
> > kfree_rcu() it, double-freeing the object. With SLUB percpu sheaves
> > batching kfree_rcu(), this surfaces as a KASAN invalid-free in
> > rcu_free_sheaf().
> >
> > struct hwsim_phy has no lock for pib. Add one and make the swap atomic
> > with rcu_replace_pointer() under it, dropping the misleading
> > rtnl_dereference().
> >
> > Reported-by: syzbot+60332fd095f8bb2946ad@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D60332fd095f8bb2946ad
> > Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > Cc: <stable@vger.kernel.org>
>
> Thank you for the patch, but I think Yousef already provided a similar
> patch:
>
> https://lore.kernel.org/all/20260627235805.17310-1-alhouseenyousef@gmail.=
com/
>
> Yousef, can you confirm you will send v2 soon?
>
> Thanks,
> Miqu=C3=A8l
