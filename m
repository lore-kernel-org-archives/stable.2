Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0674C10F1
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595405; cv=none; b=o12SJcg+ze5/zQ5O8Z2LVIVXBckZ9i8EX2MVAZj4p28OMffnkqntwcg+El29OWjZZoQt3xLs8+XwdLEjkaYzztGQ/dKPuSClWeVEFgxQdWPLwvLWnxDjVP/tgn6GpxnarqsUbIJEQlzeX4y2Jb+aUfIapMzv5f1Z3f8iBWZR5KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595405; c=relaxed/simple;
	bh=5LuhlurhvbbuX4a1TNbSji5/EqlH9U0xT8KusEpZlhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIhJ4kTIrh8fk/34IqxHcWUyyNSW6wMTSMU9TxwXVIEfUch86W5Zgco/RZpPV+/Q/FW3WfleNDHtmReG4GROGPHgxqmLT1qTKR43v9axpHXFHNHFN/qbNrcazoA6YJAO1+Bn7gc7+qEMb/odb5CZrEsqIHP0lKDTfMto34Tkamk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2YoTVCn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2YoTVCn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1091F00A3A;
	Tue, 21 Jul 2026 00:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595404;
	bh=qtB/zLtbyf5v9Rir+bp77bjah59nC+128JECSupypHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C2YoTVCnjFpN9CbxRtQdqCaFFOuEqk5VFoebljhsAJHUbhFK5l4k4xP2K9PrS1zot
	 w/rq/OC6uPkR2YELZDQl/X7CbfwaeJAS94IsRUFQ6drYf4ihe/k2SHPZ+UkrUWiv5h
	 PWq8XI6no1gO6ADzaGVqTQzchLgXZyxxj3xNC+k5e0TPr9hgAgFziLhSw0SHGr1LJU
	 XybAWelTAE0YFRszIRX5ttX+VVCWvyAWrxsXYqmaROhks6bRuk2ZARSSUEZbY9JSQa
	 x16Y4GyfMgvSxRqwYWDxSTTMJzEUerQllw1uyvMHUPQ3EDH0JWO57L/chkeX7fZXoA
	 /AWTGTDR2CZzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 6.12.y] batman-adv: ensure minimal ethernet header on TX
Date: Mon, 20 Jul 2026 20:56:18 -0400
Message-ID: <20260720175500.0011-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720132951.334751-1-sven@narfation.org>
References: <20260720132951.334751-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The batadv_interface_tx() must therefore always check itself if enough data
> is available for the ethernet header and don't rely on min_header_len.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
