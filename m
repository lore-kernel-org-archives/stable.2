Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795637776;
	b=T0fmYcyTVKttUpZkHqPphmHHOYg3eXm+TC+TT7H/nS3fnkh19qY62FIoNLIOmkb1viUn
	 53DfZ+kQ69icf+wFs64rNAJ2sbP7aeS6fTXJBDhwSUV3rcixdsXHdH0fpP05K/nSpyZdX
	 Sug5Qmu0zPM7cx6cS+YjI/z9fkr2s4kIBrApN8dyc9r8gQNb3VuPP+lF5V/mkqsOowKoc
	 pJGe+UE2BDNJ+tkYLJa275KYOVyQj8kmqE2AlyGciQJY5LFV/E5kfheBVCKjktmWPD+wX
	 dYhlMPN/srlWfHMJJoM7HYEPJQ/mnW1uH/ewu4wWvTloOjQdm+BqAhk2i1mL8FXv5nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795637776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=pHNoqtp6/IpvyophWtpnBoDa9f++9QWYTnZvFZM9okg=;
	b=CCJ7IXDHXTZMcQlAixADMd5IpMUdIHGPoWVPj5RvE/n+5iKtpD7joIp45HQ2+jQD8LE+
	 GeJ/0A6KrJFFhd6I4EEcwmBgjE+y/O24UYYfL8pixOlXp0OPr1xaYVBMipUnVFMQKBnUr
	 2QA+H9+N7OK3C156NqZMKYpXvCUK+Ah8s039xektVeqn6JiYIp/INtwQANJufFMg1OUZs
	 f7NtjJBRFOy852Kh72UmYtRgk27oOuKMMLXXk2qiJwZnM7I0gTaPEeRNbqhiuKKqGg3fd
	 SF/H1nyP3KW1b2idmSLWcllLwqOI7TLWFfl/EslR2WvgSQCXeg9Cft+p+0zFqdvfnew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qOqmNzN0;
	arc=none smtp.remote-ip=74.125.231.133
Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A0C606A699
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96A0C606A699
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qOqmNzN0
Received: by mail-oo2-f5.google.com with SMTP id 46e09a7af769-862a1dbb516so1118242a34.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795637775; x=1796242575; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pHNoqtp6/IpvyophWtpnBoDa9f++9QWYTnZvFZM9okg=;
        b=qOqmNzN0ucSw+zj8LLSgvRF92SCBjHfDrQC2yZvYHZXsYAxDiokfKSE0n6AGDO35Nh
         5ldeZTAciKwnNjalKBpIEEJsooFv1JvOvi8+dp+Y9PDGDsXhcN7dGWQvLjxArZpJEitj
         HZvwUCM2otbQvm36LvoGxZx/PQQHpZeX3iimwHCscS0a/RlR3Hj9TROv0Qpc2ex7J/IW
         rCZqBtEKN9XvCXZtGVpzlCymmpIpHSXM8OeahGAI+48YirgOWPXa8dYwZBHZpurpGOaz
         CdI3ZNrPIJsgG8VFwzt62ScAcSpORiokQ9L/SH44XJ2HyrC8krB3UMtzxDwoBfGDtV0K
         l5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795637775; x=1796242575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pHNoqtp6/IpvyophWtpnBoDa9f++9QWYTnZvFZM9okg=;
        b=gsU1rlnWToeC47WFAmCoxxCDhusdLxPbnhrB5d38hWoGuXxULXjppTS7FuWKLpsrtq
         TCmKwl+gah3StwsmQySm4idNweuPmOAdyfuM5WBiAYlXPWgPVOYnZPMrpR299WkaCVZh
         q+1TvbIS7nXzcS6HF6ICnWp9OwvR6mFECcDpmOLn1KCXdrcVPBGQvYrA+7OhiuGA8RGL
         oXv659Dvi5soqnf8UJYUG6HbWK1yKWEymj69DuBdNKCdrfat8yMqNeYAqCPEmau6MC8C
         3cWFxA+bxY9F7+lQNmxJJOGZaCQqCvlDrQo+fUFM7MwboLf1IGAFfDc6dpMi9Acewp4B
         nZig==
X-Forwarded-Encrypted: i=1; AL+hErHl0Hzovfuoh2c/kmGQxzA1An5DX1tofzUj7TqFQBLy0E/dZZ+09m42Q7xZo+iw4hUi9cKRuvo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SNzYGtlOqMtU69rZw6DggLn0rGkczQ/qa/GlC/WnwPtq63b8k
	5T0n9FSVq3aCDD9g5TKTM26wKp3Tq7fSikHNU5Hy5OgaoP3bv5cWqDO8UD8jgYUul+9IwQ==
X-Gm-Gg: AZFdTZerkI4mWgVlwT3ayefOQ4ZQ0gLbjPKVOE6xOEam+kIfbgYIP8frtLjU8NxXZNw
	yN5PhZs8iYYsuoKllA0SHzKT6apvHGcvdrYGr1ROjWgs+g0f+nFVvyNdgyV6Ki5WTP/v5c42a0h
	5RAlfQCWeMTW46tSay8qyYYViEOlQv8KLeGH1Tzgqk5NlHJsWi3+yAgZgyBA+9a1DuoTEDcqi/O
	tZYjn8ir7opPKQiycL1P0rkJKXfd3Qi/NR0i+gEfNaQHG5xB/ZX87jJ+u0sX/57c0n2meUAlPBg
	X7RneKUTXWdM52wW7lZGj9oEa9Imi4SaRy2FK8KVCuuGdP1Villf1dQ7UOlA8dL8bS3a/GMyii7
	eQas5izenqer4QmQy2/60WH4dPsgrrH02amcBkJ0lrRB5x+Pbogq7Y3dC0pkhzv6F/n6RTxYuYH
	lETo1sgVx4pokscI1uvd1bc+y5iaeBcmVqhevLpy7xxRuKlKz6b8uJYYCq9ZT8TT3LZKVTGiOyU
	ClqBN3acLaG6Fzg5pSEXh0y4I9ZC4nazFY/NW8dngeKtcvkMECcMFIt3VUJw3SswqOaSSiSbM6A
	dnrQ3D7Rzjwv0xKpkpBg72Di4GTl4iCYSc9ZxLqVd7NsDVIRkjhOC+C3
X-Received: by 2002:a05:6820:169e:b0:71b:79df:90c with SMTP id 006d021491bc7-71b79df0a27mr2553155eaf.79.1795637775644;
        Wed, 25 Nov 2026 12:16:15 -0800 (PST)
Received: from [192.168.0.98] ([50.26.120.197])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380b6f82sm11341859eaf.10.2026.11.25.12.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 12:16:15 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Wed, 25 Nov 2026 14:16:07 -0600
Subject: [PATCH v2 4/9] media: mtk-mdp: Round MT21C sources up to whole
 tiles
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-rbrue-suez-upstreaming-mtk-vcodec-mdp-fixes-v2-4-fdc047cf75a5@gmail.com>
References: <20261125-rbrue-suez-upstreaming-mtk-vcodec-mdp-fixes-v2-0-fdc047cf75a5@gmail.com>
In-Reply-To: <20261125-rbrue-suez-upstreaming-mtk-vcodec-mdp-fixes-v2-0-fdc047cf75a5@gmail.com>
To: Tiffany Lin <tiffany.lin@mediatek.com>, 
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Yunfei Dong <yunfei.dong@mediatek.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Minghsiu Tsai <minghsiu.tsai@mediatek.com>, 
 Houlong Wei <houlong.wei@mediatek.com>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Eizan Miyamoto <eizan@chromium.org>, 
 Francois Buergisser <fbuergisser@chromium.org>
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Youngjoon Lee <getfeus@gmail.com>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Ryan Brue <ryanbrue.dev@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795637766; l=1332;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=SML+TmgHSjoTNgMjQurRhuTtIXSo3udus0sid3UwpCI=;
 b=O6W72FlbWN4LuV0iiRLk2CkaYM593a8j+vtxu/b4eIoC58xSpkFVNzhRcnOAn6Ev/MJIHE5Hl
 IFgMC6jS43GCBp+hiHRxs7WXkGzOImAzk9Iax4nRoP1wVzh7g3/DYbS
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

MT21C, the MT8173 decoder's output, is laid out in tiles of 16x32
pixels, and the MDP firmware refuses a source of a size that is not a
whole number of them: converting a 1280x720 picture fails with -EINVAL
for every frame, while 1280x736, the decoder's own buffer size, works.
The alignment was 16x16, so 720 lines passed the format check.

Align MT21C to 16x32. mtk_mdp_bound_align_image() already rounds a size
up to the alignment, so a source covers its picture, and the visible
part is the crop rectangle.

Fixes: c8eb2d7e8202 ("[media] media: Add Mediatek MDP Driver")
Cc: stable@vger.kernel.org
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/media/platform/mediatek/mdp/mtk_mdp_m2m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/mdp/mtk_mdp_m2m.c b/drivers/media/platform/mediatek/mdp/mtk_mdp_m2m.c
index d2813890cceb..34d02de4453d 100644
--- a/drivers/media/platform/mediatek/mdp/mtk_mdp_m2m.c
+++ b/drivers/media/platform/mediatek/mdp/mtk_mdp_m2m.c
@@ -40,7 +40,7 @@ struct mtk_mdp_pix_limit {
 
 static struct mtk_mdp_pix_align mtk_mdp_size_align = {
 	.org_w			= 16,
-	.org_h			= 16,
+	.org_h			= 32,
 	.target_w		= 2,
 	.target_h		= 2,
 };

-- 
2.56.1

