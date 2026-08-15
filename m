Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416152989B0
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 02:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761222; cv=none; b=qHUz+Op/LmGcOiMftZI2HGhXQp54BEFAEGdhVUw/9TlypTid8kqN5OhGUQdOM4drGXsj3QWuN3WYSxbx+RmsR8aBvfXCC7JJNBcVbNyK9qc99Urq4flzrqhiB2fQPsDjQ+4TF9/4+65fFrdN1OgDiGCGetitJmTWvDrp1r7+zTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761222; c=relaxed/simple;
	bh=YBA8BgI1JvVF0UM9ppX/83/tK15mKr84yw/yto6P6hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptuZ0g6nLJA8YXhu/ictYJWSxOLPaF9upBO6o6o5zG19+PGq7wOS4xT2JDoDYCRrBF4sX+v20Nqp6R22eTMysMeEO+w7s8QCDLqLRhHbHqYKNCvHZf0mg2724c3C8WkcjX7tFcUkwJ2aiMwzcTElNqd1bKhexGNhSK7n5/iihvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxIn4Jo0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxIn4Jo0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF6F1F00A3D;
	Sat, 15 Aug 2026 02:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761220;
	bh=LSTgI1Hye3gsqMXTVgcIenGxAMo9RKwPURMzwGtNMZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mxIn4Jo0oEFMt7DB1crAQptMi8+RPtgN5LIHxP02hGiQkN1ARb83OQKpJxDLnRH6Q
	 u7g3J7SqPvKPDRaEQ0HR2tc5cdS57cPRvsX8YKCMw3WGOyqDgOEoE60hDqDDZvumE9
	 C8RY4KsYEaTjIsYa/bcmWTceCbOILrhFoMlGYIFxoIwdk4dTWvn+7oAcj//t2SkKSj
	 T4Aa7Zw20PhQyDkHDxh7FOCCEhVP5cO7AZwNJQzg6W28s6qqEY9AeJxa/6sUpJjkdC
	 rON45QgsDTqr/FL+AImt6xwe+KmNnfUE0E3JcOzDS8QdiqGDqNxcKJe4rHn6HsAsE+
	 +5W8dfFZsblrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	zohar@linux.ibm.com,
	Lincoln Wallace <locnnil0@gmail.com>
Subject: Re: [PATCH 5.10.y] ima: fix out-of-bounds read in xattr_verify()
Date: Fri, 14 Aug 2026 22:33:14 -0400
Message-ID: <20260814193000.14@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813190635.1109461-1-locnnil0@gmail.com>
References: <20260813190635.1109461-1-locnnil0@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The digest-length check in xattr_verify() mixes int and size_t:
>
> 	if (xattr_len - sizeof(xattr_value->type) - hash_start >=
> 			iint->ima_hash->length)
>
> sizeof() yields size_t, so the usual arithmetic conversions promote
> the whole left-hand side to unsigned 64-bit before the subtraction
> runs.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
