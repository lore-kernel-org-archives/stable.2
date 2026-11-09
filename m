Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239642;
	b=pxCGw0GsuhnhRmgXXBdiEQ+jot6NhkFSJiECpobWUCJCt0wz6eeOw63ZTWOsIYanI7hA
	 9hZ89DomYLsueRhV4by0vqq3P+T6kqSHlNXoeKzFkeR5Xe54aCK+HUAA2nFtpCFYpTFrz
	 +2k3FqnxUc7YaaufRj6QBzyJXCwfp4qWm8Dm5hQibzW8E2NEkEg8GDK994IiPwKtCkX7P
	 JETwgscGw/jDWVZIk08g5L6WKbKbzrgMYRkjiZq3q31gjlKkQxRzN5JOX9NFOicQGFLd7
	 Hc5aBbxUwmQ4/oLB0zv6H+g8Cy63b/nTWKIFH7JbZrwYVRXK7pR6M6bgDJy+K6r1fpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239642;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QhynUeXTwcSAR/KwaSMAEuWBx3KAgf8Lzi+ULRihMp0=;
	b=SgrgsybdRJVydSG0VGX5RD13oJ7RPGRbC6sv5uRi+CMl6SErkvMLOwV0IBngG3ziNbmg
	 2i4Mks5VaLaswVV4k9J57vwcNcGJKb96g2D9xwzPmiHQYaF71OpbQJfFJC7hlBeJm3+Iy
	 CmJ2l8TI+iMIY40ZMfLTVjPN5OJFKZoB5bPbCNEfextYbK2uYpgUsKs/bA2gSgJmLT3ed
	 22lTxq6eGQkFedNarCRFYZAprrpE0YU6LyV4knw2Eyk/hfbibyI7QqavifAjsAkqZKv1l
	 0nwRa74vLiu1S/nF+Oy8ry1adt/1gHShUJ0NCPOMptdLdS3iBE8VoDzkM++dUevDInw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lTM5tkgK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9DA606A325;
	Mon,  9 Nov 2026 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lTM5tkgK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435221F0089F;
	Mon,  9 Nov 2026 15:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239641;
	bh=QhynUeXTwcSAR/KwaSMAEuWBx3KAgf8Lzi+ULRihMp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lTM5tkgKZsV8a253kJYvuAT0z2Bj6WDX3dextB6DosfsT8Rj5gj3TA8MlrUkc99Aw
	 MknREf202E5KgXm/nUZ0gzv+EQhiD5C6ScXs9EDNUp8FcTgo2sNRh117u/ATW7ivgs
	 yPyDE/0fFwllsGsYhV+CPyd3HX6lILI/WIF624nvHxH6l+3PA7KVwVG2As7d4zSTHu
	 rAoqToNvekYITPQuSGufxHHdZvOps1HKU8bbhmlPtg18W5RHvHZNvH/7VkR49ty+IP
	 TNDCMgWNjG0eaM9UiDhfh5233GjVuVlQLRdGgF+L6STc6zBSL6Q32Gm1du807J3sho
	 xLqTDS5UchNbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 6.18.y 3/5] mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once
Date: Mon,  9 Nov 2026 10:53:16 -0500
Message-ID: <2026-11-09-1-daily-reply-0034-damon-sz-range-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108192221.114362-4-sj@kernel.org>
References: <20261108192221.114362-4-sj@kernel.org>
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

> mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
