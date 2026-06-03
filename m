Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC573B6BEC
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499693; cv=none; b=laEArbvIEtjMuZwoxmxtXxbISs0r3Mgl1lOL93hclR2CZKlL+e9hIKUoCbgtsnQGQbhVT6UYdcPos60PyWAyjwYf8bNw4HaXEkAwj3F9wiIMjuMDFHX3og/w6R39vUrSS+7YbTd5BNaqcH70MKs/CiweYxfY3SKq8Gp/QxsfwMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499693; c=relaxed/simple;
	bh=ThKjbUhLIvgxllQQs5xWIY0UL8bsv44XQePYMtNwC38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fda/Y+68gThzC/T8G9xkmqaQyM3yacDZ66rs1wjZ5CqWpnPi+08YYsyRAMEHga+lyGKL41o8AjBC5ZwNqg+UrPm27t8kl76PQlvJhp6SLfKwWd5pLJ04Ck08yTxJO5i0OXeiCAT7boRe3P7JAphGmL763GpUdi/pgqxNsMdag9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7+W+qWf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7+W+qWf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1FA1F00893;
	Wed,  3 Jun 2026 15:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499692;
	bh=PGy8UqhAM3zbEkvdrizI+kRrBIWM19hQLCmOZSeRCw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V7+W+qWfTZ2UtiyM59DQX7dgfIyBKf/tmm1xY2eJA/5kqeuM9R7qmjKhV3Amv3l0x
	 TdntTl3axbN9PfNaFws9ue9G7KI7z2WBCvZh/I/UbjHJ5eOEsyEHX0kUKlGpUNFj7q
	 CAt0jtbMZy+WOdyC0byNhO2hQo1JcWEQ57Qa0SA3Ueh+elQzYwX9ZZz//jiml2KthO
	 D3+e6OX3LjfI/NY6mNAsGVYx6jtXpu8WM1SvdZsjzqqRWiICh5dFyeftlZsb4ycA8W
	 g8e4D7hyboxHI+D2WoF0AWcWrG4sfc/U60DxHEarNBjngIv10eWdROj6GAe1UqmM/g
	 VQUkK3AFdTKtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: Re: [PATCH 6.12.y] batman-adv: tp_meter: avoid role confusion in tp_list
Date: Wed,  3 Jun 2026 11:14:17 -0400
Message-ID: <20260603111500.item048@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529180905.414737-1-sven@narfation.org>
References: <20260529180905.414737-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.6.y, 6.12.y, and 5.10.y, thanks.

-- 
Thanks,
Sasha
