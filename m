Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1B33D9520
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 06:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789887226; cv=none; b=bQnwoeiCnVC46c7hEFOC1uKwim2JT6MamK4gGZ6CYhl2gbYS/WBRXXckh2lNBSIXVn17qwJqrxoRHyyZyB+gz2MUNw1AiEVrZcXYNGkP/DRCVb47MXbrhqyAfEfhhnxETi2VC9fL0xE2NzI+WBoBZ1CLfjKUx+dDKFl+bvgeHNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789887226; c=relaxed/simple;
	bh=DuDZSD0XqCu2Mvap7vNOAj3dgSNFUKZHYo7DpbnFTAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDx4DBFQ/xlwxDSOEdl17sim9vzqZF5JfZ8K1DiwX8GtrQ+OG/sZPw+lPxDA84qdS9R0Ce0lgQqRRyv8uo/GpGwmQc1Ax15/uUQbJNlVzQ8M6Y/OKBuvxYk3YR4RFc+AFmI/Oau2GNQVAEL3aahmJOlcJv+Ugd7p5CRCfGQkJ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAq/uUIG; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAq/uUIG"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f05ffcso15295325ad.0
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 23:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789887224; x=1790492024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DuDZSD0XqCu2Mvap7vNOAj3dgSNFUKZHYo7DpbnFTAY=;
        b=FAq/uUIGkNHWEdLttX19mcV7zrPs2jqA4x2IDvONeIzdqRTeV5g5DSDpoAD2K6hKcT
         Aw7eYt3XQo8lHAUB2lqzA7fxOF6jqwwqIHlvSWi0t19jhNzE/BUX5URVVj8tzp/xzbmR
         Mf1bcdEd+cufVmHLEgXcGRf3fkvX3VzC7PWF+hjDBgxzYHqW/Nn1INroEumTllGPs7nS
         KLyhreous7FFST1U4Cw2mHU7FEa0+a8wijnOibZkrv1s68/ZO8nPFITSO1Pz0BhS86jC
         7a3J1tWiq02NypXLF4Z8FlGal1veYsmew+alRh4d1/9IxBzOaG9sWREaIbV0MLvSqFgv
         JJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789887224; x=1790492024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DuDZSD0XqCu2Mvap7vNOAj3dgSNFUKZHYo7DpbnFTAY=;
        b=2UJl/IRWmB4D3ubmKt7mvhr+UAPPqgRACgb6yIVqVcz8DQgm4ClNOcpgoOnjXROroM
         uJquk4YknVuNGnZZu7C7DGiFB1x12vSZF3huvZJT/wTmNsfatrI/Km7WN0ayL4PgOcTD
         JvFJpxyK6U/A+KwV5q8up8kwjtd0lL3569kXDfBCwDj4NQXdbUpDloORaYwXD5TDkhQq
         NhLUmV8fzcwZLnQqrtwGDRZLsqucDRIzUcCmV3EC6DIzlUx0aYV23piiuliRjaaRPByO
         Nmv/vsAmX6CSjW000TJM7uB9RFNSvmfjUnwTSBW7ybwCJRcbMou8FzST5EcWyeLc4ufb
         oP7g==
X-Forwarded-Encrypted: i=1; AKwUvBwTTGX4ZX70H0q3o58VpMo4p8fZuqV8B1sySCuYsFL60oV5SZ6rK6QlrW+Nd3DLd8CdrOZFFbs=@vger.kernel.org
X-Gm-Message-State: AFuF++mOyAYdPTHmxx3WLjeW9DwlcpbpG6KRvOGKSKABGS5pIu/b2LIz
	U/2fX7HpoXLUh6yBdmjGB4CZCFOifH3boOBc3eH4y+rs8hdNvoDeEjrP
X-Gm-Gg: AYBFou278P2TGePGzd0DgKIcu0T8o+8DfYS7L+vnBe8MoNCtummnZsL6Sfcttq9DI9S
	MFObTIUnr0arYsMIfWCfLdVMvQ46EIlLfRbDGvhjbLkTWGjKgG7AhDDTDRBiyaQhLY9EIBsIk/l
	EVp5XGiadtr79FTVv/gFPKj19Npri9Oq87nZxrtTi+s/Zzp3sbQ8gzknc/wnW/UfuVi6GSypCYh
	j2q97DInaPlthSlIQ7UPZignmrV/SX8WiXXkUNd+sn6rzHQ8u8UY77TSdQYm4+5L7w+9pFHoYJe
	Ovta40jn+R8ilY6wGNMbjFAFK1Fk1KS+ESKX2f3A6GlFkALcYIyZBv1ixs6AM0b5NUBpCaBRvqr
	9iyfD2odH1erduAVaxx6+EazqvQD/RIcHy78SZbczV8lmfyT5+vsLwfNBTXpWgO0fX+rnFQvgKe
	WcyAp3ZnAIX0X8DY4ZZ/TxKgZwkoUim8Cfi8evtXYL9NpWfzqkEArwsPB9xTbwH8A=
X-Received: by 2002:a17:903:1a8d:b0:2dd:c100:80b9 with SMTP id d9443c01a7336-2ddc100816fmr59583595ad.52.1789887224050;
        Sat, 19 Sep 2026 23:53:44 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::c570])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179ddbdsm17296615ad.35.2026.09.19.23.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 23:53:43 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: gregkh@linuxfoundation.org
Cc: xu.yang_2@nxp.com,
	hataegu0826@gmail.com,
	christophe.jaillet@wanadoo.fr,
	Frank.Li@nxp.com,
	kees@kernel.org,
	felipe.balbi@linux.intel.com,
	ruslan.bilovol@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	liuwb@xiaopeng.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_uac1_legacy: validate bRequest index in generic_{set,get}_cmd
Date: Sun, 20 Sep 2026 00:53:39 -0600
Message-ID: <20260920065339.52062-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917081832.187957-1-liuc63@xiaopeng.com>
References: <20260917081832.187957-1-liuc63@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Sep 17, 2026 at 08:18:44 AM UTC, Liu Chao wrote:
> Fixes: d355339eecd9 ("usb: gadget: function: make current f_uac1 implementation legacy")
> Cc: stable@vger.kernel.org
> Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
> Signed-off-by: Liu Chao <liuc63@xiaopeng.com>

d355339eecd9 is just a file rename. The actual origin is c47d7b09891a
("USB: audio: add USB audio class definitions", 2009-06-03), which
added struct usb_audio_control with data[5] and these two functions
unbounded in the same commit. That's the tag to use.

Fix itself is correct, I'll add Reviewed-by once it's reposted with
the right tag.

ivy
