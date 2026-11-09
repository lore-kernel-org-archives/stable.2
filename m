Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794237785;
	b=ocjWXay7gklNb5OSLfPewctwnE8O//4q0IqJEZRtCWYmlGOKGsViOUlyio5q7TrgcEbq
	 saLK8W2uHEqO82OYKVCREk9xE3tbx6xlM35YdkND0Byhqgpcp5x/zNRJMMsYd3wK7Oeld
	 NcxMsTbb6LyNzChnNExXhHnzeES0mOphDPuhYb4m6HbSw1JiIS+db/pgs9foye0jzvXHx
	 tK3c5ctKQWJdW0k1eq4fiMLEr6ScdJtMx/wwWWbWvdHa6LiiRzQ6Yvtta1mwpCrhFP1uM
	 Gl7ylD5rutPzYpwhInMb4U4Kbf80POTjWkHcBeDV7X2ytec77ack1qxF/PctOrCPqRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=mApsEmVz45av3S3Isn3l9iP+qpSKEvIgCT0J/QQ/dgA=;
	b=l3n1lVVYziOkS9tTu1uEtcwwBqFk4gdp+AmTji+aem+BCv3mrDeFJN/W75d3m7gyZ/um
	 IpSo6QgkobzDfhCF49lskxToqYO/gPF3a6GTbFrazjHE8CqjufIkWRMt9Zvv3SWflXDTN
	 qux+hSDEbwegTfEEyoykWCS2i8wVoLwOjrOpY5beUOtstrxJQChcER8zGcJu0vyH61KBz
	 6DRhW5eiPoXCvBMOYNBhO75rs5wLDk8DHc4dio+sqwd5Wwot0dH5gnRvn6DRifrO6QCAD
	 ibnNZ5GebQjV7MA7DEw+JTLV2bUnNlCvU2TMPyhf5djwwWQOWp0r/S0UbaNxiVOE2VQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nXVhbegu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7400F606A325
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7400F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nXVhbegu
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c4c9abc1824so147167466b.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 07:23:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794237784; cv=none;
        d=google.com; s=arc-20260327;
        b=du3N/Q1mDKYtLO337MkhncPmisbVNYjiolyDjQ/tbJTmsDgw0ZmC5ZHJqSFtTrB4cD
         q2xHZUJsqY+ObyRrKBud2hLiLw844VewfuM51BlOexuMVmZEo9sg2Wqq7iWbXAjX2vuO
         2y9dMH3XOTY3MVdZtfJ8OnWu/kmoI/8hHRDilSadvKGBs00991ebMd9joFqCkgKSttel
         QbVuWGqYYL+E2jxIAgBT9r+MhaQVFID08cBoAbYwVRhGhl2UnPruaqEfvqpkB3lUembR
         eDNd9fnN2y7TSGnybT2uaGmVakVq+U9ap6G4NU3XDjcVoSc0LEGc2Lu/eLaAy434iLSm
         lptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=mApsEmVz45av3S3Isn3l9iP+qpSKEvIgCT0J/QQ/dgA=;
        fh=zf1MfNV3UhtMZ/yBKSBFKnE2A9j+9yBIvQlwv1Q9oSI=;
        b=Hxpg5KEeoPsP577hraVWGxpzrwDhkDSPZ9+Ru9gGHC7xrFXIbfR6tkklrZNB9yJXhp
         x0XErhKxjuIpXfa451ilfVsUDQow49COa6U94eL7vXUnWSMbj7f5U+Eaa0N91XJza/Kk
         +86geyo0ir4qnHEmuSXmUt/o0DI3pp/y3cXXYJCKuvyxk6Z1f1219PaYn7VdfSwEWYOD
         SyYXBC2jLD1FJctPeqsrTdFnuTEr2VBbX+hsDHnoGeF1Cfn4NeWw8WXCZwHfUJ4w+1MS
         EhozN4mjUpm6GYPbCJwcUx6s/9SmLLJ9/d4gnmyMsHEPa0rYxnL/G+nvBbZizTUwcs+R
         bcSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794237784; x=1794842584; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mApsEmVz45av3S3Isn3l9iP+qpSKEvIgCT0J/QQ/dgA=;
        b=nXVhbeguPKqD0tvn7uQgnrvmhp9WKjX0PcJrzHwEXGRUFWCBmjQ1/fyV67gaUOHc3h
         8DPBM6PetfNw6YCfI9bzUdX3QhFyLnIkGi4UGBVwQ7V5kSp3dPu2HGlLs2ewrqOX6IHg
         Nr5x7m8NW+WEfgVjoIc/D+Uclq0u4mTiVfClvwQ7dXzov233J0sg2B42PdAY+85BbaZg
         fwudzQ8zSgB1K3jXTnJNjCUeNMb8Aw3PJNiWkGnH8LC/WYSeaMIqwPoGzhtRZvMaW64h
         GJ/FKk7f6BB8JFBlnH0ehHeMYJwEQtHwHzn/nZRHKgLCdNhBZXXZ+Wm4/s4HNtjaiiVG
         xfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794237784; x=1794842584;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mApsEmVz45av3S3Isn3l9iP+qpSKEvIgCT0J/QQ/dgA=;
        b=rYfNAMZXrVUymTqXhj0XR+mcIhnowmOOZQNy8cYQ9zG4jE6t+3C078L3RQ3xEhOEIw
         tNt2KK4lzvn07DOYS2zJmRfGFssuSfj7EqAayjb4r6faESokEj92EKuiXyKgAR9MZOnc
         qst+s41qcMDQFbAhzE6lfVm6sBBCFqHUjqFr/YvLUisDD0DNLeUfAMrKwjtEDrPIB3+A
         tGyq32sJfQy6Hjyo3tjAEXfjBnswyCcQ7ObShLy5XJsyZ/5fvLMuBbo5ZZgi8H/MI3OG
         UEhp0ta5hUvdr03LKuSoh0S2exmZqjHnlAThjb+zUO1xWL19Xft6rY5yy2uBXGOOaTNM
         WqXw==
X-Gm-Message-State: APuU4Z/9iJHecV0glZ5KF5Rn8UB5ZdvEj6hyEtuSzCJFNztzFa1b422k
	9ca0Uh/e4gj/YR65A1B1BfSW1Le/MEtiXldWIOT8L4vgnDbczX6crpsPEWWGcUxEh8x+L98BwdY
	ZL7HeCFIBHHblVlxXpHJlx2B2+NhPAc8=
X-Gm-Gg: AYBFou32jT/NbQ7evxcETMfFi20RzCFRD63aApv6KmfsAK2cPmUhldfvajZsKd9E8M5
	T4YpFcoc84VPJycK9to8UnbPCM2U4w5BP21CVshxEwYdtU04orkDLefC18gmvclYMFIxvpWgfpE
	4ASLA2JDSuicFquLIC98jQMZxLbRxglbk4lPI4vvhpi6BJUXiQ7yHgfgMDj4NZSOTyrseeHiNsf
	JbuoRwkPa7AX77mc1iTfzXtAI32Gh2dQkVb76M1+xzA1BtglPmz3LgwfsegG7quoCTtCPlb2xFm
	kOzzriY28deGV3T36NJ9qAnXAR0YmUiUHsZ8uYThMsWwIdmvRsouJnzST9IjuzVL1zieB0N0FaA
	yVT7kHIwaX8a2u6PdUoo6YFVrrcDCcmPZJQd/NjsuTUOvueiwnhNk6YsF1aSHnbbgRNo=
X-Received: by 2002:a17:907:96ab:b0:c2e:4b90:3c53 with SMTP id
 a640c23a62f3a-c4d6d99453fmr378630766b.1.1794237783678; Mon, 09 Nov 2026
 07:23:03 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Ramon Meireles da Silva <ramon.meireles32@gmail.com>
Date: Mon, 9 Nov 2026 12:22:51 -0300
X-Gm-Features: AclHuK-w58PVG-3Os21lYfOSRUZGOuontPIR_EhX9rP80uKsBIlg29W-z9VIghM
Message-ID: <CAN-h+BLrxhQv_Juva1P-es9m5Yk0Tv3OsxD_KM_nXxz4YiHs=g@mail.gmail.com>
Subject: Re: [PATCH 7.3 0013/1257] drm/nouveau/gsp/r570: Set GcOff = 0 in fbsr
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, lyude@redhat.com, airlied@redhat.com, 
	sashal@kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, 07 Nov 2026 13:49:39 +0000, Greg Kroah-Hartman wrote:
> 7.3-stable review patch.  If anyone has any objections, please let me know.
> ------------------
> From: Lyude Paul <lyude@redhat.com>
>
> [ Upstream commit c7abe771e013848970421e5ca29c6b2f05c31965 ]
>
> Previously, it looked as if we were able to fix suspend/resume on some
> desktops by setting Gcoff based on whether or not we were entering runtime
> PM. This was a mistake though - the only time suspend/resume would end up
> actually working was if Gcoff = 0.
[...]
> - ctrl->bEnteringGcoffState = 1;
> + ctrl->bEnteringGcoffState = 0;
>   ret = nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice, ctrl);

Please do not merge this patch into stable 7.3.

Setting bEnteringGcoffState = 0 along the patches introduced in
mainline 7.3.x may break resume from suspend, this patch was a
temporary solution in 7.2.8. In 7.3.3 suspend/resume cycle in nouveau
is properly working, you actually merged this commit twice for no
reason.
my hardware: NVIDIA RTX 3050 Laptop GPU/ Intel iGPU hybrid setup.
