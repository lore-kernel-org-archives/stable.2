Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213DF2236FA
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 03:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791514841; cv=none; b=Wy9RL5KPanTGdlGjNW5WfRyjVCGA9fbFdqYGKO1Zbpuq9dXc7pSB14c/RIiO8ja7PJ8wAqZzx7MBHoX9ZE/8v4HkGZPmBeruQvUxfFrWzyEUlsjcjJOa8goGJt7Uv+68b3nOlpjZuGwjAkfsPQ/h0KjIdOPjEM2rITUYH80/T68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791514841; c=relaxed/simple;
	bh=6PTle20WD/6VYKp3lRZfCMuqJyibbXD6XoyVTZqRYYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIlU8Ckvzg2aBFDkHwQ9BcsSVxWBtvzX5B572hmAisrsUyD4ShKZ1IVA/smHEN/dcyoc1TOuiQfju++yN1LXsSrvCSPHX9n18mrbM9wEre/1wYE7usm8Gz3VsrDk7U9Gni7FcS5fAhV2h3d7TwmjGfeus/SHA+SwYvo+HIQmf9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGW3vIna; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGW3vIna"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-754ac74c495so1260912137.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 20:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791514839; x=1792119639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8p/rQ3UH6zCn7qLdglPOcw+wjm5XRLP5ezDaCm/Zd40=;
        b=NGW3vInaleE301lviecrsKawDxigO4bbyDbezbABOrg5oO5WzPrtf47ifPFGF5H4U0
         pApidqeJFOV4CvwX3PTuaWy9lvDOBPhz+Fuw1jxy7p6mIDY0dmo2WepIZHXAf/bg5zFm
         B9N9M8eFlbAacCrKoz1Zw6za6EiJxNs8VJrh5Irdns/igVmKfeB8MxjprRsiTV1V4E+M
         2E5+PAsVKj36GJgiBohDifMjF7bG6cEnSDxtlpFWmOn8Soy/NILuBw6Ak+E23wHDZc7C
         Qb6ohn6UaDAc+kCxmI1BiGOepd9C8hCMM80qBXy+MGC4srdV658H+3O1yW+JZCyh6l3A
         PxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791514839; x=1792119639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8p/rQ3UH6zCn7qLdglPOcw+wjm5XRLP5ezDaCm/Zd40=;
        b=hjlnbuvh54x06i7lITVkOJl4NQuF6urbFhPrMUx8kyFrQqM3/QbQPEfe6kZyDllXFr
         ofmy+AaboQZoE4S427ykXsEfifDVAhOhqNOC+rWEO2wSX7zjQTKOs3o0lRG4yA+5jzuh
         INFZ2rS09MjmvL7JCWSR7Yd5mZqNfn4+fU3kpsEyfZiicwh1GaIeHDGt0QL2AnWcblZO
         z3PBjSj2QDZKtbNNIgobBqkm2pnsjhwfi3srMO4/otcgrCKGQIuv4ORZUot2eciLHoFc
         ZifkWz7DK/ZifJwXLw10TAHEmKe7j4DtVBNVmQH0MUQIRJAgmi7Yt85jeB0YkeMFDTcK
         AXNQ==
X-Forwarded-Encrypted: i=1; AKwUvBxprKi8NJ8Y3g5xAJpLCC9dNRqUqlWd0tTC07gknoqReCdxgilUiDPuL1F4Wl85zabAziJvfpA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPSpSXBFBlF30BAWAUmMHwNQrLVAkD308dzINNSEKbBNi6e7II
	ISMRbQe7deleKude45IagwLaUa5THGuqPPyPXNBdpK34XBIBb2JbZi+B
X-Gm-Gg: AYBFou3yhxqdU8hmiMuoRRupI9jfdC5N7D73UCZ+JjxmYmN0CXhAmMY7KsZVTqAUjiF
	WQr/mFDr2IYGH6tgL4KVGpN2XrZXyyvuU1Bitrq7qOUfDscMR/3jUMNoQ2xdLCLhERZtwmGVs/B
	PQVAgrn0C23uZpvaa7i/CVoLlUsMhw4FqcVbLrEbFGa2lW8YzKU/+pH6J9uphUOSKBa7cFZ4dXv
	+rKtdLZYWf3LmtqajLNuVjCVobxvTg+rXzyhSwOZ9oLwWFyYxcNNClbLUQpiuQl7L98YN3r+G3d
	1yZNGDqqhA8641E+3Jo8AGaMDNoreF8PxKvjq8S14uBJ8LxINkbkex6dY2/jsNCzT+gQsonXJjs
	uLkamqJe2JTsmhg9fyKiO5UX8xndR3dbf8g2hIo7/RpOhGKsIWqX6L3LblE0OU3CkoMUMvcJ5cm
	qnN93yXiS+KCB1v9hhebVH3T46azr1qKIcGykjyhZFGofjM+F2KVuyZrBqQxvFNOo=
X-Received: by 2002:a05:6102:5344:b0:7b5:1ca4:9df1 with SMTP id ada2fe7eead31-7cb365906c8mr241387137.5.1791514838797;
        Thu, 08 Oct 2026 20:00:38 -0700 (PDT)
Received: from beelink.. ([187.13.210.57])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e91cb29ca1sm757506e0c.8.2026.10.08.20.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 20:00:38 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/4] drm/qxl: fix multiple missing bounds checks in execbuffer relocations
Date: Fri,  9 Oct 2026 00:00:27 -0300
Message-ID: <20261009030029.3040494-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913222956.2050281-1-qwe.aldo@gmail.com>
References: <20260913222956.2050281-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dave, Gerd,

Friendly ping on this v2 series (4 patches), sent September 13.
It fixes missing bounds checks in the execbuffer relocation path:
dst_offset validation, oversized commands, cross-page kmap writes,
and src_offset truncation.  The v2 addresses the gaps found by
Sashiko AI review on v1.

Let me know if any of them need changes.

Thanks,
Aldo
