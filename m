Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0037750AC28
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635164; cv=none; b=ZFIe0oeijqCkuqz6lu7ty47+gMhMZvjXAwPLfkiq14tiRD1G2d9YfCoIK7U1MVoAANjDAhEQyKJrMZ2qiXZCSIg1ian4AZsPpQOErEzLdDXldnm0Qv0mOBqsgcOYoqoJUxZMAD3UxYCFA+wJMaA1kyX37VicRo56tCkgOIxjMkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635164; c=relaxed/simple;
	bh=SthOyFT9Tj11ppcernimxzPQe6mZ1smHL2CHpbnFlqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4jW6mNu0l517mH2I5w3U2zEU+J9vEAQNAgw8LEdKh48FlIFj3WVLH12SStcLu7bCBmbWWfsSQ1Tt9qd3g6L5EszDhwGR5Ylei4ZUv2/nhZACBX8OBSWfyP4h1gzKhRXFQRTQ94dwRopknDlpzK9ES2bBrF6nd44ruJVY/1n1ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtxXEKXt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtxXEKXt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247621F00898;
	Mon, 28 Sep 2026 22:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790635162;
	bh=8dzFfy/VK3RC4yMcOOWv8hwt9LtnCh+44OAAaNhYYRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gtxXEKXtbE/cLjBDR4C5a5duEx+m5FzQJ77ec4E9cGThJ+W1dvjcactcyHwTfVofa
	 Xr8MCZk9L7RIWs6wqF4AYdDYLhAnJpegiyMJjvbN3ZK181+iwTCDJdqiC2yn3hcfPS
	 xdR4WL68/DeuIv9PPQ2UBwKbNFETzXdQh1Ko+qza2g2iq6Ry6RL4GV+ux81ZBzTHSJ
	 7iPd+GwE48i2CDx0MPYSuwqBlxGeQDMUDtqcrfWmCWMyOFF6E96a7moT776r/Sv30a
	 +Wi0DrOx26Tb5cHQ9FTHeyD/EeL6sj/vR+Nsu7U0Yyn+KsSf5NF4KsZ6eRl7UwWZUm
	 XWZfiSoP7VOGg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	matthew.brost@intel.com,
	himal.prasad.ghimiray@intel.com,
	sashiko-bot@kernel.org,
	viktor_jaegerskuepper@freenet.de
Subject: Re: FAILED: patch "[PATCH] drm/pagemap: dma-unmap pages before handling migration errors" failed to apply to 7.2-stable tree
Date: Mon, 28 Sep 2026 18:39:12 -0400
Message-ID: <2026-09-28-2-daily-reply-0008-re-drm-pagemap-dma-unmap-7-2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <40ddcd20-cd79-4280-b3b3-16782d8b1a71@freenet.de>
References: <2026090928-daisy-vitamins-0900@gregkh> <40ddcd20-cd79-4280-b3b3-16782d8b1a71@freenet.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The patch below *now* applies to the 7.2-stable tree.
[...]
> I hope I got this right because I'm just a user.

You did. Queued for 7.2, thanks.

-- 
Thanks,
Sasha
