Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621815;
	b=itFeVoWx4OOk5TWwvO/hb5ez+dap++oUrxLy+dJXSXgVgx32p2cVnwE5wNllX98o0psf
	 brO71kquzrP2Fe2s/EMtRrgglypfrCcMiKF0EbH34DtYtA8OzIOcVr6DiQNHBvPTqIJW7
	 6RCtAIqiTVKXQ4nruA900MQsHfPpSypckioWehWNG/eMwZThHdSUqfE1E+ULflSPeitye
	 NEzoLGMcbEksBy10UXL/JWAthtjJDUIkm58+/0W33xZtL06U7nX2DPON3Ncq+v8O/RYdD
	 J8TF3iZis6ccUMEiy4cHIjHo1wP8XX2m73h2vuy4encBnY4/F9+aPE55PGqOAPrjefw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621815;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Md1mn1cIcgLEFlOztbYbIzniAp4k7PMSGrOvyrhLyw0=;
	b=AiVhitWRD34CPFMJWIy8IL59vjeRGJr6skowPmZn3sWISOvkVo7nHrL46oYxF7OjlS9o
	 J+qVme5Ukmj2F7F3OwlZSOzBD63fiZ/VYSwE7QEQRlW8cD4vNzkdO9kBwzuBkKUNPLtiM
	 FLl11CLp7Gq9wJjJdG9ARK0tLZ408b3VrpF6niWrvF2zpFzRVxB7q+33jHxgvWy/WU/qi
	 y/6x/fzlhNX0DIt01io4zTCkH2b6yWlVsIoPircc5dM2D4sjfCfY033mKjFRiBp27QzYn
	 Hnr9/xSJ+GLE3d1SZlIBO9TTRxNQE7AWwAvqcEjjt/EfAFSLoqWiJ7TLyinmDZWT2Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=cjjy9ByC;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBA8606A683;
	Wed, 25 Nov 2026 15:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFBA8606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=cjjy9ByC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=Md1mn1cIcgLEFlOztbYbIzniAp4k7PMSGrOvyrhLyw0=; t=1795621814; x=2110981814; 
	b=cjjy9ByCnCYqzWb/X/BnSzuL01+C0AblcllSZtNueB0KSGj8ZP5u5VhH/WFIK0RvPJcOx3gHMa0
	47GhDp6YBEhkgEYGpACa3wBQF4wnZrQWBXhIII1WdDvF8yPaEwFzZD0B70IX4S3TwQFHFsr3RNLu1
	Rn52KGzYU+95+OCZLqmHEy9VfnCriDJCCzoadK5JZQExORPbKVQ29OLKkSpcizHAtzj/60rZ0aER5
	mK7ItSwnXY2LbNvAMqG/hsXTNGpTtHp4MtwIBWrYPqGFRo+hH/uYXCmXHRNjYMQdxhhAjRxlg3cVN
	W1eSPyQTKY+HAYPrEj1dFGA4CKV+V9wINjwQ==;
Received: from [179.105.94.163] (helo=prince)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xWFFv-000000041TL-1gi4;
	Wed, 25 Nov 2026 16:49:59 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: mwen@igalia.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	tvrtko.ursulin@igalia.com,
	Xiaolei Wang <wangxiaolei01@kaihong.com>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	itoral@igalia.com
Subject: Re: [PATCH v3] drm/v3d: Fix double free of query arrays on parse failure
Date: Wed, 25 Nov 2026 12:49:21 -0300
Message-ID: <179562174767.111946.7948063471631555838.b4-ty@igalia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124113723.3055530-1-wangxiaolei01@kaihong.com>
References: <20261124113723.3055530-1-wangxiaolei01@kaihong.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 24 Nov 2026 11:37:23 +0000, Xiaolei Wang wrote:
> On a parse error the timestamp and performance parsers free the query
> array, and the job release path then frees it again: query_info->count
> had not been set yet, so no syncobj was put twice, but the stale array
> was handed to kvfree() a second time.
> 
> Make the job the only owner: the parsers just fill the array and record
> how far they got. count is set before the parse loop, the arrays are
> zero allocated, and the free helpers stop at the first entry that was
> never set up, which keeps put-count equal to find-count. That also
> removes the inline kvfree() of kperfmon_ids and the count arguments of
> the free helpers.
> 
> [...]

Applied to drm-misc-fixes with correct Fixes tags, thanks!

[1/1] drm/v3d: Fix double free of query arrays on parse failure
      commit: 1c986bc5918cbbb438eb57211c9d0b3de2878cd0

Best regards,
- Maíra
