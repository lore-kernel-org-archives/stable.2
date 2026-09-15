Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5B94B5CC9
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493417; cv=none; b=XKCLWD5iYdM1bImrbifVhrq2uxBU8GIv6iKi1YWd/LFGeV0OLBmiB/6MHhQi3cvI2/li7wNqHcUwDjqX65XJIx3S2Rolm14Hd2rmSuDdnYe/JhQDwLelR5K5Y4xy3uwE9F7mOim/NQhvmLjZEM2TS21uPh5uWS6kb6Uny6ro2DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493417; c=relaxed/simple;
	bh=VwBUcuZPFg1BLZxP9DxF8spw7i/So+6y5IlyEFSLMuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zk/ycY6eAvdXGQd7yZc3ezHNoX9r5UpSIJWSOklpV1BOWEX+1cprzDRuLxTDtnpKqcH6q4uu9Xg2LeL5kxillz17hERa6mo+jjXkMUw300iGamWjK+MTg1o+HysQFFyv7/XteBa7rdounakRkYqgNyiRL6wcBt8QAnTB3k6igis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7Wn94Bz; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7Wn94Bz"
Received: by mail-vs2-f43.google.com with SMTP id 71dfb90a1353d-5c83be8db39so2697912e0c.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 10:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789493415; x=1790098215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VwBUcuZPFg1BLZxP9DxF8spw7i/So+6y5IlyEFSLMuc=;
        b=Q7Wn94Bzkc0cPJ3WhAjY6HMdYj55Ak99kYmdFGRsQ/RnUKkkAUhbWXHtaybCdDWVe9
         I19BbxSTX7foWh5AoY9YQVQ4nwoGn35AoabaS5ctUSbsnvDfk/nkbwplYCvqG0rSM+pq
         EQ/84oF8P4tQIf47narpkWTTB6yE1MaGsoVOLLgxG7rBNgieObAE39WOnbqtGIVCXOyn
         yq5D4xp2hcnD8jm3G/rfg9gqvj0DT2Sl/zQlTq8ejzQZmHyvS5zxm5sdgT1xyYTXrXWm
         xNGmj/zJ+S7+MRpSwsOn3N1fp+/pvRpHQOl8+hCWarQng7vZ5sEmEmHCgBgU0C/Eun3q
         z0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789493415; x=1790098215;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VwBUcuZPFg1BLZxP9DxF8spw7i/So+6y5IlyEFSLMuc=;
        b=yRDj617Ev1D1a9aN0m7UEEfCeSJYaCLy88qzW5wftvfCCGrv5g6LcceKOxNU9Iu3OB
         aA82cRWNtfDGGooqtruuCFrK991NYr9Q/16UxtZ/tbhLVKleIhL6pINUN7wsyzFj4O+I
         4qq9SZ/561sgxA7bkWG4XCXRAe4WqG2qrOYHHwiREp5u3XOgF+BwzkwbcxIV7VHBiFgp
         Avbh00L48Zzt7xC854X2G+inzpkVtblBs7t8oZXh2rW0tlV2Brzk3ccdUrwPT3xIhbzP
         Y48n1pZYO/W8tvA1k5mZrrfOMEBCXSLsshIYrh/HIYwo3NCnlNYfe8p4iaAmgFaiuEJa
         16CA==
X-Forwarded-Encrypted: i=1; AKwUvBwh3GvxyPqBlEJDwLjMRhf1BWqPY0iN5jF4b975zqcExfrB9PDuKvcGRMQuFQ51XeGkaNwGXU8=@vger.kernel.org
X-Gm-Message-State: AFuF++nDinTjnH3x2ZP150MGd3b+QF9dzbOyc+1iNvZPPp9TX8RrpZfl
	kvvBilVLc6hpYPTKWAaudJvulZpIW/8/mdPEcc8CYTMPZxH915jxW9fJ
X-Gm-Gg: AYBFou13C4iYdkc81aIyF37UtQu1mjZ6uguF5BIDGM9RI0T/xHbUYvSUBCO4/HkTugt
	8q3HEICDffiAI0S4t1D5w08UA/tdF8k8UdCb5SkXEblS1aplfwGhbCAVud4I0M6/Cyvohc2vo9t
	eJilnyZX68mu/CRDRyW2GuhSGHwr0JwnwI23ii7gZ62JNlhr/fYqLc9keWbEhUrX0YGwLDo3kve
	dinJYV7tUvCgFLNqDE3T6ighn193S5biCpaDnc4XFHH3zqRhi2vOku3rWQG0hXdO633PVNoztPs
	dzrq+vqmNYiH0x/hhpPms6q0Yt3g1HIytwjnpBqztz66eZf54/+YfAIpR0IXnmnc9L9Chn/wimu
	9aFcwO45bRVu23HNOWn/tHLz/ABRILWnpKFgSmWH39imvX+ug77Qrtj/Ybuwf8Vj/ZAnjbHUIMd
	tf1bZBUTh0K6AXzjFvZ0VjdmpPOS/0nH180Gk80pSYx6ZHhOhrnZvN78ZZHBXYKi2r
X-Received: by 2002:a05:6122:894:b0:5c7:ebed:1018 with SMTP id 71dfb90a1353d-5c981d87e33mr5580194e0c.8.1789493415229;
        Tue, 15 Sep 2026 10:30:15 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9989fa82esm153202e0c.4.2026.09.15.10.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:30:14 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Luigi Leonardi <leonardi@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: Re: [PATCH v2] vsock: ignore empty child namespace mode writes
Date: Tue, 15 Sep 2026 14:29:33 -0300
Message-ID: <20260915172952.3174810-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915141547.3010692-1-qwe.aldo@gmail.com>
References: <20260915141547.3010692-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Luigi, Stefano,

Thanks for taking a look.

Luigi — nothing fancy, I was just reading sysctl handlers and
noticed that __vsock_net_mode_string() bails early on a zero-length
write without touching new_mode. Since the child mode can only be
set once, an empty write that sneaks through locks it with whatever
was on the stack. CONFIG_INIT_STACK_ALL_ZERO hides the whole thing,
which is probably why nobody hit it in practice.

Stefano — yeah, makes more sense to bail before calling the helper
at all. Fixed in v3, and I added the CCs I missed.

Cheers,
Aldo
