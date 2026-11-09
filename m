Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239618;
	b=rSBQCsIDLt2RTwjN6yLaFn9Y2bIw7M7ByVO31fHxXtG9fnCjxrleVrS6aokIU5jy52mS
	 rNZ6gPkZ4JDG9kFH0RRwoTe5NvHs5bIH5BnRw+0YFdPM5Ua1caK9m3PWshIajP9NmZsdg
	 Y2mGv6luerjOsq1C2sTBCCu47nUVXyloIVhHm2TCBNGhAHugE9rFLS7LLG9a5uK00s09p
	 HdFq13ENJ/uhkFWC54POmPh9OtpsQaaaDl0C6FeqZlfkxn/Xiyn44WTjC5IBSX5gLsr6K
	 PXXgwZS81pBUDN3tvNJfIAZkUJwdMvLeJ2W8fi79E1+uJlJrclwndJEAKktX3y9CcFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239618;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6r0Q5bXurPUZapW8ihCmxjppjSawVVgd64e9vTIM1kI=;
	b=Zjug7I0Ij/T4G347w3TEx0nmS9t/nxTYTQU7soYzE3R5ansMHpQHqUc7e3aEDF7/x2lE
	 c1rCnEuvPHO15nOo0qnQI7w1Qd8a13VWtnfZ0B07bYDYyEwZOs7E3jzEbDq77emfoZlgS
	 YZTTsfB18hwpflujjZqdAC7cr2CGsYMW+hARZKd9cqygf68R7f1Lz/rMFXVMmSWQ02+18
	 Lt+y5uioVy5icMXETI5JjMHDWzmgU5GbFSkqKwoE34sjwkeumwOUnk2l/jC/t8NjMYEIs
	 QnlnDfBUkyvGcaDa69cbfQtmnzWXCD6+3XCBlPbztpk8p92QqQxAoVks0U7QG3crY0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VTbkKYL8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C18606EE93
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VTbkKYL8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B28A1F008A1;
	Mon,  9 Nov 2026 15:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239617;
	bh=6r0Q5bXurPUZapW8ihCmxjppjSawVVgd64e9vTIM1kI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VTbkKYL89lJDfyCQ0v5Iq/xUK0S2uzYkinjyd08ScsQwWdYupXVf1vFORZTou6X35
	 +2YsNRNRUte5oTmsHCJrkm2R00SZvTHA5rbuOfhWzGGwkXS7BelXjzaG/sika678qC
	 j/CMnjBz2qzIaJti4+w8zlvWJNmzyezwzRzx1NNMozSKzUEtE2qr3QHO2uatvZa39I
	 AxG6cKzxlDIlgTmiHm5fnu8OkMFF3ZpdBBucxNwC4Ab+3iwpg90SOlhfVmc3rAgzS0
	 yJotA7uUbPB4LRIUCpus2Bi2pBIi1EwjwGxZqNQ9vd+WBxzAjSWaEw6hCPQysbHz7v
	 UU5FVtLYIodOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Yi Cong <yicong@kylinos.cn>,
	Felix Fietkau <nbd@nbd.name>,
	Yi Cong <cong.yi@linux.dev>
Subject: Re: [PATCH 6.12.y] wifi: mt76: mt792x: fix negative errno truncation in offload capability
Date: Mon,  9 Nov 2026 10:52:53 -0500
Message-ID: <2026-11-09-1-daily-reply-0011-mt76-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109023436.52407-1-cong.yi@linux.dev>
References: <20261109023436.52407-1-cong.yi@linux.dev>
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

> wifi: mt76: mt792x: fix negative errno truncation in offload capability

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
