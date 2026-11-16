Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794869477;
	b=GzrxrmC3JyAJDadEWs6VW2b0WSgWe5ie80A1V2smiK/8Iy8w1rYRVaT7Ba8a8b6pzWle
	 XSmcL6nF5Igt41SgoyBtkDsbY4fLE8z+OvqityYLFbdy0bs7cSBt6Wv+NoUimVDvzAUOC
	 nI92YLivBqq64knnyRrAcWRzsHpl1Ngc9W4KiIXeU45HCOZ2Y8JmX25vAv/XZkKH8SLce
	 8YoKus+qOn4ALQoiMtL3ChhJm73fftothUhmElDkjTBPhqH4sPFKx/514wKVYwQXmJpaC
	 gQYrN/JjTQrcwtflp/dcMhm+f7tl+c9Iqn8sqAH+39TnEBkCuEMifR4ZpfAYyvE+2Bg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794869477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4R6GMf+N1WSGNe7ynv/fMp2cLGWJ15ixMnxyfrCx9Yw=;
	b=JBU5QB14eZkOtRF1F8gMrgEGlY4kv/LJcS/Os3mPdM9jNdBDxu7RuVBFlVdpTh5uYARF
	 Q993dddC6Imbhsu8L2irnfKdMbOL2AamyLv2a3jA4KQONwhydb0u6mnXtgTXzTAC4SRrh
	 /afDv3cutQq6fMIvNZnWBZek53u/tB+xbLFYQuxCTcIX5Mv3p2/Ei/u2AQ7Ixw+D5nH8F
	 RilNN2s7JErc7WH7eOZ1N4BPzSrLEI7I44qy7/4dBB7LN2NcKkfz6NV9bzHL2Pp7MrupY
	 Uq7A7KIxvwnuZ7A8J2aAcyYDi9co2zm7Ne9R+oEVlOWq9ISU1WzvB/3IamIwSFkKqFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="kk/p/EUZ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0405E606A32A
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 22:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0405E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kk/p/EUZ
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5c14f7768acso3278182e87.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:51:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794869475; cv=none;
        d=google.com; s=arc-20260327;
        b=BSpWtBgQKhNudtJeSJdO3ht58zP94xrM3rYLLiyQPemJU9EwESHP9Fy493SnmoPPbX
         awae2AJ8Ble0ID9+f7qwKffAK7cY7GK/ex212p9bWCNhcS75ldim4syCIZtayQ6gvsiG
         +KTgvjnlmheO8aELd9NVYfVQdtyUi+FHu74gdcr6voX5mx4TV6PPkF05jdD7SIpHZe3X
         1PV1uGMWQqD2g0hb9QIPekMqVw2Zv/yqNZCC48Lo8tY2HtiQsTI4XlAemh4m0SP+KLvx
         LlveCA2oCVxw5hepYVjUPC59DTfUU9fpcPqGyFJj1ms4maeVwbp6qbVfaw8+zQuKyJyc
         /Qgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4R6GMf+N1WSGNe7ynv/fMp2cLGWJ15ixMnxyfrCx9Yw=;
        fh=Nf9Ysg7WS9RhkDP3Uv99eoKR5ozIvNuG7qI9LCfmT9s=;
        b=PfV0mc6xjiFnmmiaRRoC0XWs8pgf+zRbvgxA40fCd4kEFkt/Zgx+EQKQOAXuo6/SJ0
         Os5tdWX5l+1fP8FjvMvt2X73K5PyGElGos2GG7DKokZdJUpVH5Oqt9gRiKL4zCjqlhoH
         vW28N/w9ZL+ffRcTONVUIjlJkeuah9m/1Q011pSUiNNiUXxI5FdVcJ+fA0p1rts52PUG
         oL8JcG+3LYeZITcgugEF+wcGIsWH5NSSQjNuBGMliy4cxlQYq2rI6JR8zyZm2a6RQD+8
         +Ovl8+NIPVGdCmAKkxKfX4+L3DQRhEYLz9c1jN9LoLymWrjk8VEFChqGf/VMg+sLYr0E
         /9Ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794869475; x=1795474275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4R6GMf+N1WSGNe7ynv/fMp2cLGWJ15ixMnxyfrCx9Yw=;
        b=kk/p/EUZ42VJ5YgKv1Wn3i+cPwj2SErCTRW7L793OJ0KFsNhCm9BuTgxw25M436hxE
         V+gWlsQN7/eDt/WsiMaip+OKOnsd8INibpn5VjqY0nM8LEycYyq8fhFtSzsxtVa09VYI
         mX1qReotK4FksPWQDUjL98HvDzHNaBfLnKgBYWSR17ox+RhuSN+LMYvEsxJvXJH2IUHW
         BHmkCG2FVqHRuiswoAB0HnlpuNtJsPDeRalmZzkIGnNMdhEtE/lVhJyBu2SepnE9Dqzb
         wC2kJSVYH3Y1/rbV6xzEoYbWB7cHhGoewD2w7T2axTp0Mv+VXe4PGlgaLvzVgchabuwg
         wldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794869475; x=1795474275;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4R6GMf+N1WSGNe7ynv/fMp2cLGWJ15ixMnxyfrCx9Yw=;
        b=yB5k70zs38KjtcJtc/Cuh9BNyYKb4eEx15Sqo9oqyA7YJ5571W8m6KmVme3dAEB0Uq
         Povx55KoAW/FelWjD+CNBndaC3CrvY5W5s5Y9Av0R/jVSGweVW2COUzzryYtX3y26G//
         e0UTTquezst+nJlVY+z5lJqa4QcTH0cbZj67iUyNKKIKULZ4wt0nIrRVUjvkCBQcp3j2
         3EBca1IpmdJ2u9Un+hhMd6Jq5GFhhwZ+sPhOfJrDRXWAo+59UGQBAcqtQMciL0JhcVS0
         sphxAfnjIBq3kMkJrt8aYAdZNR/CnYiretK3zlBn7D5SSO69O52okD5erQ6iA+ev99BW
         GQyw==
X-Forwarded-Encrypted: i=1; AL+hErH+Zs+xzwttpWB9Qtxj0j4CUf1H/QSomgdJal3DArpHaaUomha/yR7SGQ5yLVhFaes+kS2ZSbE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NKmDOLGbPma8LRtJ0Ce33pEbIy7V7JM+DlSzFMCJE3oDuMxFe
	Dpu5CNFsARRc5QizeqQzyTZyXriJoZLEUNWNLYwuQ+12QI56ZgrHB0CnpgOhPK+IADinhgoznWy
	Y/W0Bl3BA6JNax2RIRvlOFx3Va62RxYA=
X-Gm-Gg: AYBFou0qiOE5Uwf4rMQyCuARNINJNP+4u9N8WyAIa/NAH7Sm4yAvsZiXA1boGkX3Se1
	nwrg51EU5/RVr4fJEskDIgdNRMU/UVky8LuvfKJOGl2FWzuCpo5QZloUWSMds+h8M7D2UNjWN9d
	6TL6M4MZ9qtfjJfZ6goMYeYa9SH6Aek9ncxoQSvO3ke5vrdgDd523v9MMRpOBbtQBsVBb9jqeU0
	s5MuH5DF54AzPmfotzHxxZmc1vaCRUfPVZuhkC3LAKJwbS2sIRTjovEy69yDOu602E15Qbk2kNS
	QnoYW6ja5ohQxsvNZphTEdDdzT08jgKKhtSH/Vxtpoiz+RcAS61akcUyjsmaaqFSu4BAl7D5+EM
	g6BHx0D1MTUnxDB7/Dplh84xwZu+eUDXETNd/a6bPxV6wzPJ7qcE3zjkxRoG0w2wZuzW7MsN6Ah
	1Txs3SrKIo33Xp3crycMKKksNrtQ==
X-Received: by 2002:a05:6512:31c3:b0:5c1:4f6f:564c with SMTP id
 2adb3069b0e04-5c1709c5b64mr4475988e87.39.1794869474886; Mon, 16 Nov 2026
 14:51:14 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116224803.61154-1-festevam@gmail.com> <20261116224803.61154-3-festevam@gmail.com>
In-Reply-To: <20261116224803.61154-3-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 16 Nov 2026 19:51:01 -0300
X-Gm-Features: Aa3M54oXe-IAn7x15degHvby6uCIkABaEwDsnl3MJEDi4r1Iu6Ak5t9VY_ssJ7s
Message-ID: <CAOMZO5CPym+AYFLv7D-mAH+OQXL_83yForV3GaSk4ReT_x1HrQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] mfd: mxs-lradc: Pass parent IRQs to child drivers
To: lee@kernel.org
Cc: maz@kernel.org, andy@kernel.org, jic23@kernel.org, 
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, mfd@lists.linux.dev, 
	linux-iio@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	stable@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 7:48=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:


> Changes since v4:
> - Map the LRADC MMIO range once in the parent.
> - Share lradc->base with both children.
> - Remove duplicate child memory resources, preventing the unbind use-afte=
r-free,
> as reported by Sashiko:
> https://sashiko.dev/#/patchset/20261110141934.42490-1-festevam@gmail.com?=
part=3D2

Sorry, the correct URL is:

https://sashiko.dev/#/patchset/20261113013212.470981-1-festevam@gmail.com?p=
art=3D2
