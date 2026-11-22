Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795318768;
	b=gAwtg14I6Rpnubt7XcaB4QvXProLfgGXiaY2Yr02llcZWKMdRA3M9NZVq49AhSGYm9P0
	 DdUpeZRJS5HJv6Ug03xSaWMXWND5gVNMzI/zYvqxbWtIHShlRM+rredO/+O3MbvCZc4H5
	 p1Lsc63FB0eZ+aAuMOOYFcPJQ35HjGRVJg/Azcq/SUE3iaBXy91yR3X367K23l2uR2/7o
	 G6zxVG8/7nEhbWpIxaEvh8UikBZY8AV3TCO9rPsLzV9+++XMedW6ZuH/ODMMFoY5tNCkK
	 L8ZN6vb04ic+fwoHMTLs5PyJlPc6V8FIhcQGfO1RBpFphPAFFDnsElAQ09W0CPOz46A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795318768;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/+6Z/yXHZ9aPY7iRRrJtU085JLC9sUUlNrzE7VJ9G10=;
	b=PaRyIG1xSs+hlbnVhmPSZXH2mDc4Yev0Mzap/llM6AEB9Iafzox5xduEunnkoLov/qsK
	 TgVwtyaPCIicZjerTcnQaqJG1wdBOLKXNIZwcNwRaPkyQ2pqnQJpmv7iUfsfSs8gBiPC6
	 EU5iuUlGueu/zzkUoti4cD7a9gS6HDscSln68Av2/HZJxL+GxFvXW46pQMVbpgjIiQNVl
	 tBbPvIipakszGmXEuvxWvyub6/Dov2pimbr57D4oya8odrw4OI/lj+RbJfCtMUKQ3Y2gx
	 RSel9nXCTo9o4BSSy5bipbUKb+aa1Yx/oAAgCv6nvXH/EjJ5aCNUvgu1jzauKzVrKiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=glse7pca;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F86606A32A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 03:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=glse7pca
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4427C1F000CA;
	Sun, 22 Nov 2026 03:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795318767;
	bh=/+6Z/yXHZ9aPY7iRRrJtU085JLC9sUUlNrzE7VJ9G10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=glse7pcaHZnwTPoFMCJXhRy3cSHUy6MSLeNYjIx4gJRN3zGEviiQsxz6bcN6Cmo5b
	 RhEXwvuS+NfHQy/M3Z0Q42sOdfx8v7IEvS0zIeR2qdxxVA52x0yAkd2TQxOTgKkFNJ
	 2wlz3yDnUCUwKxjYgjTNw8Yb0SDvAsLi1L9bH0FGqc0kqq81g+kauvcj7o+u0A9D4I
	 +HQO15MbSNq3gYD7zMMbLmT8U7wFRfooMoaoEaORuJRkgtKHpk72PBtOtCHWgqVXYk
	 t4ve+D0gDpTKNYk1LaP+3F4m+X3NQUAoKTDPYv/GmTNPSQxrcdodZhE0guB0ZXKv5o
	 Og4J03EepKNtg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	jack@suse.cz,
	Aymen T <atijari00@gmail.com>
Subject: Re: [6.1.y] udf: VAT inode size checks
Date: Sat, 21 Nov 2026 22:38:53 -0500
Message-ID: <2026-11-21-2-daily-reply-0010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aac8e196-3fbb-4445-b154-5b9129dde41e@gmail.com>
References: <aac8e196-3fbb-4445-b154-5b9129dde41e@gmail.com>
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

> Please consider these two for 6.1.y:
>
>   5163e6ee1ea7 ("udf: validate VAT inode size for old VAT format")
>   49f771d14578 ("udf: validate vat20->lengthHeader and VAT inode size in udf_load_vat()")

Queued for 7.3 (which already had the first one), 6.18, 6.12, 6.6, 6.1,
5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
