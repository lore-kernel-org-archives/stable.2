Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795678877;
	b=CFiUIvjfL+vEheMMRZPwjtxEd1LC9U9UuttNUmuPNEwej7aw7VjTq3t5XoyQpsArMSBr
	 LkixggFncLs6OAEVAry+HFtdZtSoEzJ9W1SXuvkMC2QygBApwAjv6p+OAyphotke1GaKs
	 E2wfqzqXm7Nb6r/3OHqN+LRztLrdYqAmQVK642A9DKwRXYJWItQutR/kDReCjNHw0ewgW
	 qrwQZmBCrTgsw+/IGA8iMOSwbW7IOWV2+iCvjO9hm9iaRkFCVacS8Edk9YsmM53oB72xJ
	 TI6lhr2evRMgeSjtxbERzeTcFriTR0M0B+zLgz+hMpIqbp51Sx378BtGrphSNbxO3Iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795678877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=q+Ubm2QAGWkkevqcn++H+wXuVangaT2LjNLkyOWvZa4=;
	b=k9NQBQp7dMREVRptnJaPZp3eDkyNW+7FYXENNSf7b+eZd8gvMkiEhTRdHxkO7VzRqWI9
	 Ea0+tFWp0Ui7//LQdoGfWFHkUxvnP9WBKis7UEUQkzy2VHrswXIUzT+gmkhgWo36t3OSW
	 VnNWUQ1hfx/0ebp+PvROGoVKVR0u7lafF+puzwxQy7uPDuWh5lk70ZJhWB7MTK/7nB7vl
	 Nz9n7Facly8ur3cjb9Gz8sAZuEjVK1/rLNLfsk2eUUX3uKC3YFkXpUeLFjwyYWNQgdqaq
	 8e7QsvgNVOZAYYgm2+yYdi9EIcK/KerQfgFYgp+08wkkb+rDUPtOaGvziw0YSxFwXcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vjYWWtOT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBB7606A33E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 07:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BBB7606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vjYWWtOT
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91f0274f88cso88424736d6.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 23:41:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795678876; cv=none;
        d=google.com; s=arc-20260327;
        b=O56ZRtTkFSSu5M6TjYHHt4NoRgMDBh8M8bskOD4o1WIOQ26YgL8oxaGMQejHcP4iWY
         OsL7tIVc45GVbcL8bQO4UED7CzrsQ6R5NqN1wqcayRB1kbYw2FS+fjyhoabv+QcVPoeC
         0A2v3phXYcG4i2+2lEQ2JmW3UIecdkVrRoCwg9VJV6tsfGfnBpLNQlct1jiUljJVfg0L
         Qga2iKHP3DrcI69XsWx4/yiy4pbMGio81NVGOT8Xn7zMxUIB47876WHEcyTtbeDBaSlk
         ocQbFdsEhuR61/5r0GkmCZ8EbfIGIk+vFB7vtP+eg/o721VRRGoBG29DVnrM0iNZ4yG4
         qp0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q+Ubm2QAGWkkevqcn++H+wXuVangaT2LjNLkyOWvZa4=;
        fh=hek+ANSaYqmCzW42Dm+9eDt2ZSdqLcJUfAt2EYW5TnM=;
        b=H1ndCEx+idACbQ4DEPrg+XhtY/4W1ufNamzXJHM3piSN1j957ZypnA03uOyh+L1UvD
         z4Daymlg4IUEeZqrkjgi99DAYDo4qgEnhWAlCM4BTQnnUr/5+1vn/RD2zFGcVLGScpPN
         r39envHuNoN62sp0l/HSlH3KrgS2QYrRpka7d0+Hmb8xOEx2QvVCgddwOfmPMqgmr3B9
         HRwNncLKP2t7DmPU4Xe57nFHxIiD9gWmxX5eEx8pZiO7DZ03WhE32AfTVL3eKs/uxhSU
         8fFHEJt1ayODeCuCWU6poQfw0br0Xg5Fd6oF9VcFA7pfWbee74icVU/YADll/UT3YIgE
         S5ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795678876; x=1796283676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q+Ubm2QAGWkkevqcn++H+wXuVangaT2LjNLkyOWvZa4=;
        b=vjYWWtOTVjxpRitCs1Ov3QfzRRQ2tY06zy3Y4ik8hHED3h0mwrmhU4UHOeuxdpnybT
         7K0KCZprMY+v7Kf3EnwopbyboNiElX037NRr3V/r8mrSPbt0dydicTRGKCNM/YvakosY
         DeFt3u1m6GAKDxGX0FP7t0dj/wi37BL+9UGm/YJ+/WM03m2s6XB3JpF6UXxiVEOgR5+P
         cTgi43oizecs1Yim1tbYfiQipIDE1BH6qm26/gMv3m/BnArrLv5J+9iKty2YWpjH93QA
         QI3RxCRnkIkW7Ab/zCVx5SJlLYJ5y19biI3QXqmrVdCqPbG9V7gxMUJTtvgwFum0snZ9
         peCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795678876; x=1796283676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q+Ubm2QAGWkkevqcn++H+wXuVangaT2LjNLkyOWvZa4=;
        b=xhUTAdN8ZR2IQOTz/0rcERKXcU2iuDrVfudxfMJQtipuZ1O9HgwousQBaiLy/ZXgES
         ZxCNMkHaF6V1hD3XimbiwxIPIPF0L8YjZ+MDlyE/MSqNty7Hhx8lh1tHUt06TxxjMWuw
         ybkcsJBCNkRhpKdQyRvMPPnjYBEJS5OiQSCrCRGMVFbHBANrAChJH+zAtrtsIK1J+EuB
         uCvabFp1TilF87a4XFIk/ltn/+LlWikOCy6AQu4pIEXtcUUHcf2TMSoGC8JiYLu2+Glc
         M/CWHvVmG0xrFuq4onl0N6asGFIWBYC+TEa1nLRseMwo1kE/P8BHcHhdYOR1aJcMZZj6
         CZRA==
X-Gm-Message-State: APuU4Z86ijxN7ERR0y+D+jSsIi1qshn+eyVCN2pGmwQ+ZMA11REFBf1o
	t3VxpMjLxqVIK/ZWEpHvyRpc0+2YpU51OG34OUr0Xdq+hw6vdkGT+qTMFyg83tkItwym/+GDo3C
	6brTxomefTAY7t25AUjd8D3rXuvRi934=
X-Gm-Gg: AZFdTZdZ4jgvePmxmo8R+C0fktQqqRt9wib71edoRkRmwStXoMsLArlv3mYC33b5+R8
	2DcJR/KkGwHPdlSDCHDUDYKoC4ddbxDMEg5krn+Y3Z8O1QkvdrTPGgScCJiYaBumrnErvhelRmd
	VTt+h60P5RDKN/9X9wQq7KxL5io0Gl7JXOMkKoAZAKxYuk851aR5XeAhfPnu+pbj2K+SyjLzQpY
	cuw0oTuk1CblU+LmzJOfvpxcIgb6iSHBDlhjyetPoWJ5g+fERWhqk+kGiOStAGLbcJ+pfL8xJR3
	VrkzOK4cPdFasOTkFLE88ShoksuhuH3UsBUGD+id37PQsndaH6sstS72hQTxIXKHCuDrjv54xXt
	mhTu2nFwrle2hoRLXyQSzj8+RhgR3qfjRbUQ6UEK4NbUXt4GSNOYXMF6uY5DTBrbubv8uNYIcSW
	QP1d2/HWoohLB/VB8MQw==
X-Received: by 2002:a05:6214:8616:b0:91f:2374:d001 with SMTP id
 6a1803df08f44-92134aef4e6mr379882716d6.25.1795678876352; Wed, 25 Nov 2026
 23:41:16 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAMcAce97zgo7c2f5Th9FguAHEL5gL87NrJ9MJkJghMm6M44g6Q@mail.gmail.com>
 <2026112651-peso-sandy-64a1@gregkh>
In-Reply-To: <2026112651-peso-sandy-64a1@gregkh>
From: Yingke Xiao <inkxiao12@gmail.com>
Date: Thu, 26 Nov 2026 02:41:05 -0500
X-Gm-Features: Aa3M54oG0R2UVhL1kMFuTme6_Ok82BveIP2T0l92n5M8-7IZtdNkPstPzAyhzvA
Message-ID: <CAMcAce-_hShop0MH1Q4p6Y0uf=ApmLoxuKQ9Kjms_4s-Gv1epw@mail.gmail.com>
Subject: Re: [PATCH 6.12.y v2] bpf: Reject NULL data/sig in bpf_verify_pkcs7_signature
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org, kpsingh@kernel.org, 
	sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the mistyped full SHA-1 in this earlier v2 email.
The valid upstream commit is 49b18315be4eecfc36b75f4aecb4d40a87d68a20
("bpf: Reject NULL data/sig in bpf_verify_pkcs7_signature"), which was
corrected in v3 and already queued as [PATCH 6.12 015/816]. Please
ignore this old v2 thread.

Thanks,
Yingke

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2026=E5=B9=B411=E6=9C=8826=E6=
=97=A5=E5=91=A8=E5=9B=9B 02:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 19, 2026 at 11:55:07AM -0500, Yingke Xiao wrote:
> > [ Upstream commit 49b18315be4e590fae0fc39c87d46c87e9ec903c ]
>
> Not a valid upstream git id :(
