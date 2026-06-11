Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D90229D260;
	Thu, 11 Jun 2026 01:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781142478; cv=none; b=Ugbpyurw+wjrzvnvrhsBIYDeQCaqZF384hZ8MUH0ghtKE/br+5vJqBiIyUjpWaPtyOkFYclU0cpwHVUwrncwmnEDxQt/Y9cBO1LJB8u1xnS0/8SN2c7HHtMUoyGvxEYsBDHgfG91eWgZr/nnMIbnQroDpGXsBQwKx+tQrGLyMXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781142478; c=relaxed/simple;
	bh=rGEDa4n0SEmzwCZfmOGuyYCiiy2Jdo9UatczktZzSGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qeJ8NUEKS9xgfJG9IN9eHaKfQfGOFJndC/bRJKFMysJDr2FhSHPguOEsj6WC9g1hoPMZ1UlnkgYwfussXp/IOlWhbU9D6REenZA0SHYVJLALw3ZxAE2WEgscxbtjoeNx935KWJ07dCCIXXPzwXUBQIaFE43x/hioJkKqai7xrSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PchVRmt9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PchVRmt9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863AD1F00893;
	Thu, 11 Jun 2026 01:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781142477;
	bh=smJoTTOO8GMvLnoRHpzbrXceEZCyWiBjbuGxdoVLRB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PchVRmt9np2w8mKzq1JAbDBR/cS+/PxOn6O3P0cJo9KMG5Yg5h6WHERRSx7yDSi5g
	 ZlzH7NEh9SBcS6t68mRandQqt1Q0Na1kDtuiXBpmlaM6NnAv4m14tz5v3DMUyRfAYs
	 9yRNNL+unsu2CiuoZ52K3redH7OQ30stoyjXUGxLfQfIWVZcCOPdnoeAOP0yilQm64
	 GBc4CtAZ3JR6uYSzaL1R/tgCMUqkgvxkydkNPRSdJpN2BugJIJ6I2+iDaDHC9cnslG
	 /kZWcLeYgnaNsgV2iLGAa6vJy9p2PEF93LmYgZDBfj7kgxOPZg0ltpazvIauqYqz7j
	 HKCWGT0Xx2iow==
From: Bjorn Andersson <andersson@kernel.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rishabh Bhatnagar <rishabhb@codeaurora.org>,
	Gurbir Arora <gurbaror@codeaurora.org>,
	Siddharth Gupta <sidgup@codeaurora.org>,
	Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: kernel@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: Re: [PATCH v2] remoteproc: qcom: Fix leak when custom dump_segments addition fails
Date: Wed, 10 Jun 2026 20:47:46 -0500
Message-ID: <178114245716.590736.9900237601117073742.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318-rproc-memleak-v2-1-ade70ab858f2@oss.qualcomm.com>
References: <20260318-rproc-memleak-v2-1-ade70ab858f2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 18 Mar 2026 17:19:16 +0530, Wasim Nazir wrote:
> Free allocated minidump_region 'name' in qcom_add_minidump_segments()
> when failing before adding the region to 'dump_segments'. Otherwise,
> the 'name' is not tracked and is never freed by qcom_minidump_cleanup().
> 
> Return error when adding to 'dump_segments' fails.
> 
> 
> [...]

Applied, thanks!

[1/1] remoteproc: qcom: Fix leak when custom dump_segments addition fails
      commit: ecf9fc18e62c58eae1ceb65dab2bccb8a724de2d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
