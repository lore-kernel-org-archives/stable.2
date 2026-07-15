Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C674242BC48;
	Wed, 15 Jul 2026 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074367; cv=none; b=BtJGg/T1488Xago3ERpHdZMOnjOIZ8PbC3TgNT500pHEXlV4CpzjoEedZR3q6hBH6a7FxkQgkICg7mMa6AIa04tykc54PLYJs9PRjFRd/9ZzX7EkF+8FHKzxq5X3D9lFZn7JcIQpqduZCmhd72UXtc5F7lHq8BWU3/heV2Hbdgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074367; c=relaxed/simple;
	bh=CWM9F1iysRhwkY8shCmhGLfQhqdIpHfof0/a13aSaZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5mvq3Deshp43YHytYjR9KwWWSulMuQ1phv5W+F6PRxICsNnXJbgN1XCaJLxqldk/jQD4XpScxXk+CXD5I/+dHLX40QyZPWrSZEI0F5mEo7j6l7KbLtfSD538iK6HPgyqhJalBAgagjrLerT/Lt6nWkUDJG8pggo80o14AKynpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWnx+NYf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWnx+NYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E4C1F000E9;
	Wed, 15 Jul 2026 00:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074366;
	bh=ozXR1slcn31dh4aPRCoJtnpI58JF0zu6o/7FlOEgDic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FWnx+NYfb5FwvhodlMCqyYy9nh3ePVb+3EJrWivJxXTvWSGs82XAB8VIaNaCfAPy5
	 Q3FbGZplUvSxCvjPSZ40TLOAypiEZz5xFWI+WM6pCfzbJW1LhKI0A/KR+Dq/KhaWGJ
	 UIYEWddX9euan+TWsq3cmbfVlR8oHSU5WMHgea3BtfH03wg865U2kX+cMugDjJE8dA
	 4LKczmP/eTHCNC/VDIiU6AmvcTsS/ViXEgkzzE0ibsfX4uVzg05YnwTmKphqJo7i1e
	 R7yBSHNUnUsL+QRgQAC404+8LwGj69OaCPOqrMejp4sh+ZDO78lAppi/M+kafGSqD6
	 O21DeDJrhipZg==
From: Sasha Levin <sashal@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"hughd@google.com" <hughd@google.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	"kasong@tencent.com" <kasong@tencent.com>,
	"baohua@kernel.org" <baohua@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?UTF-8?q?=E7=94=B0=E5=AD=9D=E6=96=8C?= <tianxiaobin@xiaomi.com>,
	=?UTF-8?q?=E4=BF=9E=E4=B8=9C=E6=96=8C?= <yudongbin@xiaomi.com>,
	=?UTF-8?q?=E6=9D=8E=E9=B9=8F=E7=A8=8B?= <xiaoyaoli@xiaomi.com>,
	=?UTF-8?q?=E9=A9=AC=E8=B6=85?= <machao26@xiaomi.com>
Subject: =?UTF-8?q?Re=3A=20=E5=9B=9E=E5=A4=8D=3A=20=E5=9B=9E=E5=A4=8D=3A=20=5BExternal=20Mail=5D=5BPATCH=206=2E18=2Ey=20v2=5D=20mm=3A=20shmem=3A=20fix=20potential=20livelock=20issue=20for=20shmem=20direct=20swapin?=
Date: Tue, 14 Jul 2026 20:12:30 -0400
Message-ID: <20260714200600.stable0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <777ee2cd231642c682560b41b29798fb@xiaomi.com>
References: <777ee2cd231642c682560b41b29798fb@xiaomi.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> We have conducted stress tests on over 10 pcs for 40 hours each, and no
> relevant issues have been reproduced.
> Tested-by: Ma Chao <machao26@xiaomi.com>

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
