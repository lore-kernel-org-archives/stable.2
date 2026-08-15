Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E25A2931F8
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 02:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761227; cv=none; b=MZLNnRWO0V9vtLPtXzdsoysASYGrZAyusy7Oi1UHn0JxzwnfyI1UMDpVs27VumvNGY1B7b0MjYpC+hP+CPv0W9Wbx5VK40YgDuU1jqtK+cZZsCwDJFAnWo8mqA4cOzmQX6AKHak5JKhzvj6IGCEVksk/yTzLBja2yKN34tvZBdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761227; c=relaxed/simple;
	bh=xrKLRvEcIwfiUTcBIFYvN95S8/5tO+lngbms7GRRrPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OspTQx4LUI53r0lDj/IrmjVJ+oX8KSG44x66Nr+Gfq9VVX3u/OX6uh0WeG34IcMk0k+1PNKHVIeCKnvDrfBXY/Y0UJPqgvFVJ2DInZTftpdo8XQhvfvp5L2GaICZY3CSMcLV8U2CbL8kLLWxDkGQynmH351/Z6YiXyflBjzJC6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHPlpUSt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHPlpUSt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535FF1F000E9;
	Sat, 15 Aug 2026 02:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761226;
	bh=zm4hfNG7aIr4xBdYXgqVBT1ZMGexy6bcXoC4zsjhVHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FHPlpUStnA02vNrHbOEQq0bZj/WWbIES7AtFMMow9oHJEboeQnq16Lo7iViWwHObb
	 NZaLwQu522ceP2YgAxnDrfVqG48JPRgkUGay8x7NPVOIrmQeabAduTrPzQOArWUPXF
	 v3NekmWrkqWdrgkfumH/Kb+eS55kg6rE4LNYiRJDT2KFmh1MUnjcb9CSLNZkF/Q7WP
	 ooJIGj5a4+MwPKbcuVA7m+w92ahd+sykthYvpWrPVKutnuPKMbyRDi6zPSgigI8y3i
	 GEiO+NTa3QZtBvgOBf8TzmAAewrvwC1QnamdhG0wc2Fcc8Hc6z5H0X0mU65fGJdo4I
	 8daOvcIZqDObQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	harshit.m.mogalapalli@oracle.com,
	gregkh@linuxfoundation.org,
	krzk+dt@kernel.org,
	andersson@kernel.org,
	krzysztof.kozlowski@oss.qualcomm.com,
	kuldeep.singh@oss.qualcomm.com,
	Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH PATCH 6.12.y] dt-bindings: crypto: qcom,ice: Fix missing power-domain and iface clk
Date: Fri, 14 Aug 2026 22:33:19 -0400
Message-ID: <20260814193000.19@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812-adapt-ice-binding-for-6-12-v1-1-ba4374b81a3e@oss.qualcomm.com>
References: <20260812-adapt-ice-binding-for-6-12-v1-1-ba4374b81a3e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The DT bindings for inline-crypto engine do not specify the UFS_PHY_GDSC
> power-domain and iface clock. Without enabling the iface clock and the
> associated power-domain the ICE hardware cannot function correctly and
> leads to unclocked hardware accesses being observed during probe.

Queued for 6.12 and 6.6, thanks. 6.6 has the same released-DTS-versus-schema
gap and takes this patch as-is, so I applied it there too.

-- 
Thanks,
Sasha
