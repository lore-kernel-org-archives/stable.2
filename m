Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793383715;
	b=Vozt3O/sAeh+CIpQkUgpjlM+oeclDTLE1sQtBltT/TuqiceUHIcf9JGvAETz3ZohkGEq
	 o3s6Fdlqu7VQUQozvQzSwJFjfXXtI+ndCRXZtDgbVvjU0y3Kdq3tR8jwraf1Nq+0iMIl/
	 tG2AaQ+gZv8/RDG7mtM0KV4Ql4CovzT+mkB9MoNVaB6SAxNU1RipxgqlD7LzxaYBNzeew
	 Yv2Go45QkqXA/3Jg4U226u3mZTkgPqI+AWaXgGagDfr8WwCbYe4RdsDFP0KCWrDvsS9el
	 qwXGYitOByCnqOAweNuNeUUK42EPOFgTdSCl0cuaiCL5m2YK+XsATOyc3QaMpLZ00AA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383715;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QVKMydU/thLME4tk0hjz4sP1iIZCD+FNDdETjFTH1wc=;
	b=0Hz7CQI6T/Lx0XAN5r+UfWD0joDl9fkefZpPuScYbsHs7vkpOscl7xK/E3rAUUEXfXO/
	 f1FT7hdG3XJnUd2nwP/0M1UHQSdALNHX/fkv89Aw5+nlafqPzqwXOLTyP2TrFsptjPkYf
	 WZscgn1ME0ViV7iL4cR8ioHyo7IDXL+ugA6C3xMmnhmTDBIy9e0O4sD5/I7DZPBVYnn0M
	 jCYAh8lKh4CEA0bmhNHUImRH1M3PxROi9jxhsmLkmd03TKvILyv8H47Z3oXB0C/5syE2+
	 wCtiQ+hCYa68cftSvDReYGQmh47SOi1iji1LvQBLMiajxyaueY7Zhem17q6S9DZKzww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=Lposd8Qn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44EF606A31C;
	Fri, 30 Oct 2026 18:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C44EF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=Lposd8Qn
ARC-Seal: i=1; a=rsa-sha256; t=1793383674; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=D3MBAA2RV9JUP7T4/6JJ77ZbLpLnUGmQ/f9MrNVw4WNZBARPtkxqnAMycgC/xNDAPEDv2qTbNMxscTwgNBnxzAWVKMa5r8KKL0eGriVTorMspzOOFXwtkEGy0s7DPuMiMUjNlaegbLPAW5q4cAQ9H5GPugl3ZvVszL88FAdhKDo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1793383674; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QVKMydU/thLME4tk0hjz4sP1iIZCD+FNDdETjFTH1wc=; 
	b=Vbi6DAafjCVdxAwf6rg5DHUhXcXD2xRYQxxnv19Rf9KxZmFgQZVzxm1Ne/DEnGzFeJY8elq7OmWBnjUVgFP9TD9lcPsOOvxX4Wcv4ifYBT0nkJ7MeFM6/XwRCgWGKD+rxkOB0HQvdbVNWrdsEw7M8ELvTf/qPsSQ7PLMboCBGm0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=Lposd8Qn9kdkRC2sYlxa0WOlkAA0mdUn3f0TOBw4v4w4+IF365qd8Ir3d6eaXQ0+vDAC8JhV8+cWFCuguva1v/4S+OWFZvObVFblzFE2C9crKE8F3KHvtz30JTSYCjecrxq/b1CBY0wxs/CNFsEbuGj2wI9PXEN9fdWmR8kLEPE=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=QVKMydU/thLME4tk0hjz4sP1iIZCD+FNDdETjFTH1wc=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793383672930887.0016081954384;
	Fri, 30 Oct 2026 19:07:52 +0100 (CET)
From: Igor Velkov <iav@iav.lv>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, Detlev Casanova <detlev.casanova@collabora.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Hans Verkuil <hverkuil+cisco@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Diederik de Haas <diederik@cknow-tech.com>, Jonas Karlman <jonas@kwiboo.se>, Francesco Saverio Pavone <pavone.lawyer@gmail.com>, linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH] media: rkvdec: Do not keep the clocks enabled from probe
Date: Fri, 30 Oct 2026 20:05:00 +0200
Message-ID: <20261030-rkvdec-runtime-pm-clocks-nicolas-reply-1@iav.lv>
In-Reply-To: <76e2e993fa5a8fd054bad97505907d3c4e88e11c.camel@collabora.com>
References: <20261030-rkvdec-runtime-pm-clocks-v1-1-fb2c5b629e79@iav.lv> <76e2e993fa5a8fd054bad97505907d3c4e88e11c.camel@collabora.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Fri, 30 Oct 2026 08:49:03 -0400, Nicolas Dufresne wrote:
> So if CONFIG_PM is not set, the initial resume will never occur, and first mmio
> access will likely hang the CPU. We need a clean pattern to handle this, and
> perhaps review other similar drivers while at it.

PM=n only happens with COMPILE_TEST: ARCH_ROCKCHIP selects PM on arm64 and
arm. rkvdec had the same gap until 6a846f7d72c7; rga and rkisp1 have it today.
v2 keeps the clocks enabled from probe when PM is off, as etnaviv and v3d do:
https://lore.kernel.org/r/20261030-rkvdec-runtime-pm-clocks-v2-1-8ff510a231de@iav.lv
rga and rkisp1 as separate patches?
