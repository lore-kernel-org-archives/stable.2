Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084095;
	b=lB5mI3w+kMOg66IRBNjEMeO80LxdLYfgNGZ5rFxol1lrTFe1hEP8HncsSD4+nuzF3tBF
	 VoInKaG2FDWpRmXwi6eU3FSDLW5KO9sB7bkhNhOV93nwSAgxrXTsIhEAg07crG6c4FhGb
	 Nvdwvt0W97On3ZLo9Zi3W+08Eq7L3MPfO25vQtF59Ad3E4NSi1bP4diyNTMm3MnnPhBKb
	 a1vbaN0Mfgs0WXgP1Jl6SOSZSlrBFjSbQd/NfyK/tUUa/62V1oW4cxvCBigMxeFKFPHyt
	 KLiQ8Xg0oUIcE+eV3UqExnUkt+JSc2XvPeFv6Viat0aFskeYZUKxa/ioMG7jQCl+IfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oEXr1K3EZeJQI84eHYprlnMC5Rarw55WE3zGp6jDEkE=;
	b=FkfzgnfUsD5sccpKWAn1SlZ57rhPjpi4mFgV3n7hklOEIsYFaL7tgkDcU3H3CxdxS5n1
	 cDKNPsiRR3rBUH1w0cDpcGMnOf+CrrprFAPN81qLojNZU+TgOA5V/8qijLL9wRYYkFDBd
	 KOhZ68jh6FsXSH0gSHUcYXbbKPJ63cF1fmNC1gIiGOUw3ogUC228+luw/fiPYjuaXz4A9
	 7XQdcSU5e4EFbxl9CikcUFJhHkhyrasH8YuCCIsVvGs4NX5I21H8jBhwamc0TQtodBOa+
	 P3fNlCxGE3qXqwKzJA0QUrb9W5C/+5UJGNY8KOfDTty27bap3jmdMQuWr3K/3xDu8XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Rbm2u1OD;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5372D606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 06:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5372D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Rbm2u1OD
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so25639705e9.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 23:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793084094; x=1793688894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oEXr1K3EZeJQI84eHYprlnMC5Rarw55WE3zGp6jDEkE=;
        b=Rbm2u1ODARNBL1tpPkHcrJM/nHYPU7J8ag3G/Z7wD9ZUxWbcU8zU2GfDy84PQZqBxI
         olGNMC0m9AmkJQMUoBagRXCjfUWnRf72LOO6b8ZKHnif1ixuAo87CkfIcCF2+c6oDo5N
         Zl90Q0Y0wquDTGNCkQp7AsQhS8KWjiVBICgCGQoFmHqGDy//4y8okmwwXdrNLN3LRqUn
         XiNDojM4jhEPtC8xX8wW9xNGR7AXZDCLKqCLWasUszZSmZgmWpmE2DYt/pIL21A0gmmU
         hDfGOgrCWfkynb4anQleTR8DpQW2ISV5cbX4aiTSdtuXDutGLv4CwG/UtbOyuEuXkiPd
         FiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793084094; x=1793688894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oEXr1K3EZeJQI84eHYprlnMC5Rarw55WE3zGp6jDEkE=;
        b=K898ESprVbkzOdvNlWtn20P/BYTOtMxP4kGqaflO8KJ7lNEHcnC5Yq0sCKfR5JBU0x
         U9W0/C+9FmcjuSQbicSYugyDkheuFUWCYe968ViJEmix/X6lRS1J3J8BYDTXF7F1PdHi
         4JICKexDlti8w5jhlvs3mrdGVJYCbDZOGjYBZgfZ7peXvEk3ujmm7dTcuO+bSw1+NcS4
         MsC+PpLU92rZ1/YMPM9K0TQRmTOZnOzPunKFMZ96z+GNsq9yFqPxkoZlZd7TJ593bXUi
         egNLxJ0Xa44KQQdKoSQF7tzTtgX8bHcqwx1xzyqIZRtoFh987NnWsJoz927HNpi6/DVt
         oBLw==
X-Forwarded-Encrypted: i=1; AKwUvBxxaBsCLfJI+8IlILVPrqGPbhmFBPSU022Fx1mNUVYgcU3OfQKJ3n2QSPRs6JCgj35R7BaGdQc=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7vGL2QNv2Z0nNsHPgRLMO9JyiBPavXjZdw9lfhX1pZsO+k3HC
	D8wm5UsTOZyEde6e9rmVul1+RM3bzIHyXFWeibKEot7hzBP5fjIIy9YK
X-Gm-Gg: AYBFou2vkDtqKXd/Jqugyr3mf7oNSlu5K7Kyoi5VJpF8uiZcNe9PpL8zeymBy9pRHry
	CjQlLX+yHUqqEWncbbo1ewQZFGBgzn5a+fTFWIBNnjF/eJoDEYsXcAUsPmxFwxfkk/GMbpYCTkI
	p82XDkqCcExJ47hbZ3tc/Wus1qQZy305BZ3criqpyNVi6TUXicDgS7kWeK6Fspiuh7H4C6S2/Qe
	rl/coKrvRSidtYcvcOY+cTE/HZDJM39gxs7srhfwgKkBALud/O6Kp3GNChoGd00bbFe1YaM0FQH
	d+yq1n0XubKyHVZGV+pce4RJ/HpnTkDlTqu0UxLIoxUxRHJ+aam7yO7jzBBk6uMF8vGsZcZH/pE
	TEd/qDTPMuRCJEVTo4o17ECN40U/ovqZIo9crwNv6Y2TBN7dI7AwppxPcVYgfI1MCftlbJuJMLs
	7krvkpu8EVokPVUz7+AAvjAY95IR6HM80WrAlM+x6nWFV0O1z61EpJCUzUsh3X1fOtFyVmVsDY9
	EuqCykCZqerWWIvJv2wM/gDAiw1nPzeNfy715duYn1bMci67VpzaCcsY4kwZYsv1bwAZbRskn8U
	uD7AwkUPb2nncK6h7eucO4hbUbwIPfHtEyozFEKXbRb1tu07AD9kDHI/yxuTdYxgclOZAIiBpn3
	4cTObYZGjaDwTHvp5ylT/NkGLBREAbP9RKWuhrv6D0XwpGWEwcavnEWFsPRXth4mDPNnASGtZnp
	HnCACw
X-Received: by 2002:a05:600c:46c3:b0:4a2:fd2:9855 with SMTP id 5b1f17b1804b1-4a35acbd173mr173946805e9.13.1793084093615;
        Mon, 26 Oct 2026 23:54:53 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2ac-9b01-6900-1f92-d182-4435.310.pool.telefonica.de. [2a02:3100:b2ac:9b01:6900:1f92:d182:4435])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a4cb7bece3sm189318425e9.10.2026.10.26.23.54.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 23:54:52 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aaron Kling <webgeek1234@gmail.com>,
	linux-tegra@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix NVDEC boot on Tegra210
Date: Tue, 27 Oct 2026 07:54:46 +0100
Message-Id: <20261027065446.97098-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261015-b4-t210-pd_nvdec-nesting-v1-0-39a36b622eac@nvidia.com>
References: <20261015-b4-t210-pd_nvdec-nesting-v1-0-39a36b622eac@nvidia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Oct 15, 2026 at 06:58:01PM +0900, Mikko Perttunen wrote:
> On Tegra210, parts of the NVDEC hardware unit are in the NVJPG power
> domain. According to the TRM, the NVJPG power domains must always be
> ungated while the NVDEC power domain is ungated. Model the dependency in
> device tree.
>
> The first PMC patch updates the PMC driver to handle cases where a PMC
> power domain depends on another PMC power domain (other than the core
> domain). The second device tree patch adds the dependency in the device
> tree.

Tested on Jetson Nano (Tegra210, 7000e400.pmc and 54480000.nvdec with
nvidia/tegra210/nvdec.bin) on v7.3-rc2 (5b0764a53235):

- Unpatched: pm_genpd_summary lists nvdec as a top-level domain while
  nvjpg stays off-0. Writing "on" to
  /sys/bus/platform/devices/54480000.nvdec/power/control immediately
  resets the board into TegraBoot.
- With both patches applied: pm_genpd_summary registers nvdec as a child
  subdomain of nvjpg. Writing "on" to 54480000.nvdec/power/control
  powers on both nvjpg and nvdec, boots the Falcon firmware, and puts
  54480000.nvdec into runtime_status=active. Writing "auto" powers both
  nvdec and nvjpg back to off-0.

Tested-by: Karl Mehltretter <kmehltretter@gmail.com>

Thanks,
Karl
