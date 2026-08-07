Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFFD3C416B
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103132; cv=none; b=S/rGIMiRmTfWescb4jvfEBYZzydGqa2u+x8ZXLfAO3sm5XElkCptx/jQ3T40WzqSqXbMbdZbaOKoK3zoNWR8sn9kyFnDpVtmF53ts6sijCA0ojm++SY56xv/U68vE/P1aGLbd9gRtFLJCzJyQcLjcc6/88TVHqoS6txOELTq4AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103132; c=relaxed/simple;
	bh=AqOjwA+fyeMlkfdBElQcFTSoaFQEzXv/uxfXk3HioOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ue2oWFVWyLmqO02rhqKs1GBLnovHsih56He3ZfmNvwaoUJXjKPshMXj5PiKs11b+3H1XT9jrDiJgKHOfEjV3GKd3TK6n4FB5Fe/OxIvLnrw65/m46Bkl1L87oubFCyhKibBjE5kq0e29Ckmpx92ovl+SntQ6jDKOh1b/+gcF27M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpBSLbu7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpBSLbu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4351F000E9;
	Fri,  7 Aug 2026 11:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786103109;
	bh=4fIsUldULIaC0MWQKqk57oNvo2kpovLrTcAHwv/xdzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XpBSLbu75zt6T6N/reDErAnhMzLBTNJ/4lCeuuL3wrLLB7w4pgAcsuSGNI+QM/Wsc
	 KvScPUP/eiSJqr93YmXQcKkpWR/rFr9JtVx524QecZulejUg4/I0t4s5qoV2HrXfw8
	 llZepkSXN5s23h7gtJyXj57NXejhC6YaJAj23dFaluz0xJ/Wx4AW3XVh6eRETcF9jM
	 ZUKvgq47brVypteSY9zIsOZjoknwhfQbqhT/Psq/CZbA0xWtJpv3qRCpeO6efoMThb
	 heP0pvd5krz9gb2LwGvd3OUMB226PB0c2Y+s1YNTn3WD4Mk8wb0RRo1qELDeal6Ltp
	 gEVsSyrDOX3jw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	Leo Li <sunpeng.li@amd.com>,
	David Weber <weber.aulendorf@gmail.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 7.1.y] drm/amd/display: Exit idle optimizations before programming
Date: Fri,  7 Aug 2026 07:45:05 -0400
Message-ID: <20260806234000.stable-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805163314.214623-1-sunpeng.li@amd.com>
References: <2026080547-scoff-that-5ce1@gregkh> <20260805163314.214623-1-sunpeng.li@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 05, 2026 at 12:33:14PM -0400, sunpeng.li@amd.com wrote:
> Prior to the tagged "Fixes:" change, drm_vblank_get() was called before
> the workqueue flush. This ordering ensures that PSR exit occurred before
> programming. After the "Fixes:" change, drm_vblank_get() is called after
> the workqueue flush, leading to programming while idle optimizations are
> still active.

Queued for 7.1 and 6.18, with the "check GRPH_FLIP status before sending
event" prerequisite applied ahead of it on both trees, thanks.

-- 
Thanks,
Sasha
