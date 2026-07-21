Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C74371889
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595402; cv=none; b=fds2lvA5tbsW7S05b+IAObQK732WjHcWSCJ5ZuYnnjjtiMxP9p3e6ihtlSwC9tJL/hCl8fQPmMV86CKVE8Mnq9PQLNIZPDIfSRVQfN1XQ6r+hr7tLjsZUgky2eER8Iucyjl2oNICPtPsUcWtdX0nyPXJ/Z35PbNla3OkkYApKlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595402; c=relaxed/simple;
	bh=sxFQ+PAwdCFMxw5y9JGShJzWMXfDLZxeBAh0sjB4gro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIV+pPoIbsuCte5X9AIki6rsrOrJZvo3k9mBXzF9LnYYB/QvsUjsPKW1h61zYOdfuhXvTEUgs35DSUBNWdqQAfYF2Am/pn88okWlwrdZcoDulmpWHtrsLFR1vYnSVwN8ekduiVlGaGEYUXTt8SfygFoPsDkx6jrh0cAlBVRUJ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kiea7BMa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kiea7BMa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901E31F00A3A;
	Tue, 21 Jul 2026 00:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595401;
	bh=80H0uWOfZ4whr2ag41fW8us8TZaknd+wxINw+BWTTz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kiea7BMaNPBrvyMAkW1r6QS8fQaIa/C3HgV5795Fn4EgzLrVWNQB1sxsBtsQ0g+9/
	 fmXTYUNcWG2ZRmV2pSafWKUUeuWF7oAEU5uI32SxJq0eVsl9D7j4sbTuOrUoB1gwB+
	 GCH9YWoj90CYsMY0RkTYrkZrMRtI0vkp8+7OVaz/FbJurQZ5yzzmxo/uy/HN0vLSFg
	 X3p6XrPSTFpnyMsaUEnaIJzWhNyd1+BbfZZ1SuDCX2/3S3I4RE6g/5LbHNcr+YvZYy
	 XJPiMLcZ0zRlrRErNjpJa70pHFdsh7qhIiohRiRaA7AfOJPasOhW+YoJ3FSFPC+C8p
	 RhnmtDULlWA/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 6.12.y] batman-adv: retrieve ethhdr after potential skb realloc on RX
Date: Mon, 20 Jul 2026 20:56:13 -0400
Message-ID: <20260720175500.0006-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720131459.69396-1-sven@narfation.org>
References: <20260720131459.69396-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> pskb_may_pull() in batadv_interface_rx() could reallocate the buffer behind
> the skb. Variables which were pointing to the old buffer need to be
> reassigned to avoid an use-after-free.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
