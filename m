Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCC524C06A;
	Sun, 19 Jul 2026 05:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784440607; cv=none; b=XNZ85sDZO1FmY2UCgCmpg7xkNTTgHnO6H0oSVTGLdNCwwrf0DpfdPgJJDyit4TnxrZKTNGV9cvon+OY81nZqxqHUO1pViiRwe8UlwbQPlnr88+QQ7984eVCm/bIrSwxqjcKhapLfK/veqQ66nD32sVLEOM6OpWimLgwFAYd8dwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784440607; c=relaxed/simple;
	bh=Rk5XJFsDHZN7e3GVhvCU6m6VaZlbeKFwxzT4t+yxyC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pXulkTqejG2Aph+dwAxWsPuXDVVaMQVTkoL2U+I+w8A5Hk6jbicgB1j6aNPJTExCfPc+rZIeUSzxNuNHc98cod65ase3OExveDc/nCZ9nGTMW5PWhXwHE5FOZj4WptGHdWeaVQzHv3MtHmtEGa+/Mlcb0BEpdYPHoohIm62mpRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CRMzj5tg; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CRMzj5tg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Rk
	5XJFsDHZN7e3GVhvCU6m6VaZlbeKFwxzT4t+yxyC8=; b=CRMzj5tg/y+p75+oMI
	CB1mTFHbrq5LYFRCuQjZyJgX8nwC7LinLatwdLCb+m3FSVEYDMJvuCUj/xbjm9SZ
	1TrL9h9oC3wWpGb0/AroMq21x242b4wWtOir9QHN6RrBEpaf1dx7W27i8sRYzd1G
	J0FyC3kzSPGMf79au0LwL2fkw=
Received: from QD202103290168A.neusoft.internal (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wB3+1zdZlxqb9mrJA--.4249S2;
	Sun, 19 Jul 2026 13:55:45 +0800 (CST)
From: Jianing Li <m13940358460@163.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Jianing Li <m13940358460@163.com>,
	Iskren Chernev <me@iskren.info>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matheus Castello <matheus@castello.eng.br>,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: max17040: handle missing status supplier
Date: Sun, 19 Jul 2026 13:55:35 +0800
Message-Id: <20260719055535.1831-1-m13940358460@163.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20260701061042.1008-1-m13940358460@163.com>
References: <20260701061042.1008-1-m13940358460@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3+1zdZlxqb9mrJA--.4249S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRXxhlDUUUU
X-CM-SenderInfo: jprtmkaqtvmkiwq6il2tof0z/xtbC4AKDvWpcZuIGCAAA3g

Hi,

Gentle ping on this patch.

Thanks,
Jianing

