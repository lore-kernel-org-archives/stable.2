Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053463B6363
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 11:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486163; cv=none; b=FvcPnJ1cpRmXLECsjR9S/o/PLrlhZqYD5h/4nP83dWNGetGO1Z74z5SZFCqDKPZHIvRRaUJmr8GbUWYiqW7yJ+5ifNCv5P7NbJiH8cLNmb/CWqsr35OXJA98lbEOunQvY5aac4iLi52yti3TXMMIw7ezYGUEU+iLD0ZbjmRgI9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486163; c=relaxed/simple;
	bh=EzgO7LomJ/NnedQH0f+oMIVugNuiq7tvJGss4s4zaBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6EtwfYeZ7HXjf0KgqMmX2PymXDkFYvljWMciPNNqSjRq01BgaAezKxrW/OumfymM7FSljlqjENnQjFaIZR029QJoL9sWbegzrLzZY7LJ+iTYRzziQpfmbnDRK9frM+S0GNXL5nFwKY9mQUtj0IxfaphM7VXyId38YOgPFcW1i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=F7jHwa4c; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="F7jHwa4c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mLrKlo1LN8FKrEJ/SnHUH3VZeJqUrTK6SvkjrFmBAno=; b=F7jHwa4c8+ka8n0arJDaLRc/Qm
	/d1nPhPbbkKWAkNKvj/yyB9lt4vvrqHHCHRv/nq+DIglvfr+sKz6StbxhW00XMIJNgCMf239jA3Bp
	q5UlI33/ZXvzRAlwxa4XQbPBA6Gw5nPKfr8U68Fo2f69nYHB4ebbmUwxd0LZL2Fjt2BUKulSo63PI
	ASMPVSRGx0BMXkiCgDZS4pISVLGbSla4ClLmLeFtvad98d7nhPJrN3zRudsZPPfpOpdoPcMVp8eWe
	p2biKISK3m9YBdF87EtvIMiNHKymMBh63RRsD4OYAoODEsriM0JuQPyn66E7CUze2B+z7vNrF8I+s
	XxMPPRpw==;
Received: from [189.7.87.67] (helo=prince)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wUjme-00C95u-NK; Wed, 03 Jun 2026 13:29:17 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Melissa Wen <mwen@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 0/2] drm/v3d: Fix indirect CSD jobs with zeroed workgroups
Date: Wed,  3 Jun 2026 08:28:25 -0300
Message-ID: <178048610287.3112865.4242414505352419021.b4-ty@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602-v3d-fix-indirect-csd-v4-0-654309e32bc0@igalia.com>
References: <20260602-v3d-fix-indirect-csd-v4-0-654309e32bc0@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 02 Jun 2026 14:50:13 -0300, Maíra Canal wrote:
> Indirect CSD lets userspace defer the workgroup counts to a GPU buffer
> that is only filled at runtime, so the counts are unknown at submission
> time and can legitimately turn out to be zero.
> 
> However, exercing this case exposed two issues in the CSD path.
> 
>   1. Virtual address leaks when the indirect CSD has zeroed workgroups.
> 
> [...]

Applied, thanks!

[1/2] drm/v3d: Fix vaddr leak when indirect CSD has zeroed workgroups
      commit: ae7676952790f421c40918e2586a2c9f12a682b6
[2/2] drm/v3d: Skip CSD when it has zeroed workgroups
      commit: 7f93fad5ea0affc9e1505dd0f7596c0fdb496213

Best regards,
- Maíra
