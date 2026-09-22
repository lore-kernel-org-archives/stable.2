Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98759545DA0
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081290; cv=none; b=MJSTy3rC/SmWr1fpGE4liZ0ySV20CdJXdQBQIgK9v/k4aFER6s/eB3VX5TdrBHf0eGG2w5wB3miTOxm0g5YlXdmsKOQfyihvxJ3NUvgyL6qoUPbOBlha47AoLXTklbx8QMb6q8ZMqVAnkPErzpbvdJUstWsoK8pVakj0qPJDlvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081290; c=relaxed/simple;
	bh=QVFwYIiKUZVL+YjJoBnUJAKPe/wKV4GXCUpDX8JPQGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cecAeNk5LwJK0lOi+rogw539zgyaPHnMHDPcsh0CuEyVmdld/jzBAHWvWztKtfBbGp/euJLkAiaF3YdA6lPpsg6C23Uq2Sa454fnfm44GAUvtYs3rOVXn/7cQlaHyys7n/QVBVO4bbypK2pQ6YU4hJGTHs5WCu3PpRkisNEoegs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYsHQOUJ; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYsHQOUJ"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so3077220a91.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 05:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790081288; x=1790686088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QVFwYIiKUZVL+YjJoBnUJAKPe/wKV4GXCUpDX8JPQGA=;
        b=aYsHQOUJk8gURJi/wRAffvbYAr+oEuDTWRAItRq/qCgXtqxo3hvP3NZs5BSqDmhwmM
         yiXCaIYl9kiVqJmvFS/nH818r5prYUCi0RF5OSTM+8XznXvBcBPnuL2XqcVINEjvCWpt
         t6ahYriwMQ9DmqX97K+Ro58vmGGR7CA0XN60P0BrOFupN+b/cLCST1QaZNaviWJ2uQux
         ESeQazpkBDC8rUXDcQoyAO0mQ01UMV44omwe7b+BgNCp7d3jCrlf+Lb4x5DK4njRe9lA
         dmzKI8iSY3u/4Tp5XuLzMaGVIhnTLMXS3OyrMNk/U+U1sBSnKj+RsmbZS5ZOLUEvJI/t
         Voiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790081288; x=1790686088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QVFwYIiKUZVL+YjJoBnUJAKPe/wKV4GXCUpDX8JPQGA=;
        b=Mi644gADWPTQnqkQtzaM+Gf2BnupDG2IolbKdxSPT5iGVNHAr8bM0k3+nLTi2jplTl
         ErV2wldhv76jCpQM2XCiMaB1sdA6Db2aZrXIh+sMLGqZk3c73YFlyiZseZCfPRNyuNG3
         M3XiWQppS/i5PKVNsZbaBldXvxkChp/lUb64UOmtZW3X6Pogy/9P/p8ptjeWFt3U04oY
         aqALBkhAo72nuSqrkWFPuosybpqnNL/7RLmVZxeKapl/TBbSHeMwpyr76k+8Rg+9TiPa
         0hrAZqWuFcUFQ7dnSFJqG7wdGBe9iCmWimeXwotCE4V8gUTmf2nKebM383yV5lBctmIa
         EpTg==
X-Forwarded-Encrypted: i=1; AKwUvBwh7Jiv+alqV2AkPYEcrqXa7fz554lCPSDILzJVmmhCjDnK5+xMCmHjAMNK50agnNILhHOdRxg=@vger.kernel.org
X-Gm-Message-State: AFuF++lXXwOBCOiIz2skRQXQD7MtWx0Lfjoo4JgiLG+PSW/k1Bkt9i/G
	dffFff+DCaszYjDVQ1N0zBE866Odw6CdAgnP7AdYJ7sahGxFFltnGuM=
X-Gm-Gg: AYBFou1w/3W8wjQ9Aq064rIb14wMWGmVoOntRmfBlU0lC624aIE/CcjR7TVWiFTkQJ/
	BuFu3MsOYtKjRTme2sFQsQgSo4Vu82Y3TyaG6iMEr4kJa1ovh29HZhAipx5xtSLyWUERdVTIpE1
	r/2b+TlNBMtbZeHj9tjnIHGxDiWZeagcWx4q9u4IKZq1MqQWt9B9IrUXs9gEbOfsRLDgMExRwWC
	c26AgmvTUJBWkVv5ov+Tl4C+ixBkXNn2Rk00Me5LLAYzk+ywT6VTUqCzDyEXo5jzVsv9Ajw95Ne
	xlkvUYnmLPq26jL6iljww0HeeHZkxMHfKLa6Mx0192WuIn8o23vbyfL9ebDwYmqpBeQgK8BpOof
	lXP514zVielxyGyFnkUzC3hIej6NMJgKbhIbgDbi62RRYY7ZZS8io11vjk866s8O9OYri37Cwey
	jChY+lVyyleH0H7/KoY4dDQBCaK2WsoGiJk9LcjWh/XmPLga4PRF4sbTTS+lg4i6IamW2iy+bX1
	od8nMaoFtwtV/PCdceon2IloFBH
X-Received: by 2002:a17:90b:582e:b0:38e:bbf1:de3f with SMTP id 98e67ed59e1d1-3a0730d0610mr995564a91.12.1790081287829;
        Tue, 22 Sep 2026 05:48:07 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:2466:805a:e198:cde8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06e574c49sm3442051a91.8.2026.09.22.05.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:48:07 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: rppt@kernel.org
Cc: akpm@linux-foundation.org,
	peterx@redhat.com,
	surenb@google.com,
	aarcange@redhat.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	mhocko@suse.com,
	shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH v1 1/2] userfaultfd: clear the inherited uffd bit in move_swap_pte()
Date: Tue, 22 Sep 2026 21:47:59 +0900
Message-ID: <20260922124759.1676901-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <arIj-DZ3BtxMEzLB@kernel.org>
References: <20260919004630.1159895-2-donggeunyoo.kernel@gmail.com> <arIj-DZ3BtxMEzLB@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the review.

I'll rewrite the changelog for readability and add the Assisted-by tag
in v2.
