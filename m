Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11B3239E7E;
	Mon,  3 Aug 2026 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785771809; cv=none; b=TKO+h3iqGVRkmFy925iIhPuVXuBfYDbskIoGY5oraHy2qNmuupsA9LFpLTUcuAD3EYBpFVN61x5DdsPT/5JRJBcolCYUXQKvlTVK92a185QJhAMhO+3VyuQtj0ZHp3AqXT7SaYfUYv70FFVwuZQbH0NUxKI3zr9J+Velto67XVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785771809; c=relaxed/simple;
	bh=489LSWSROeDX5KUk3MIjI3VtRPQFNLK/zTNRdV4bN0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puLCt2SyPNKEWCUiYAVE7FeM0b8zq6OPnV9lSj/jXbS76lSHReCIuQB4z0SYQnlznd92JTq4K9BD+kjgWEotjFdOZzJ7F6i96KGfRpEzXzMDp7Hf+3VozD8JPxE11XoBHRH5kk3c1VSU1BZZnWFnAfw0nHM5rtJL4Xn762tEGKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TGjmVsJe; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TGjmVsJe"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 111F9143D;
	Mon,  3 Aug 2026 08:43:23 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.2.197.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC6B63F66F;
	Mon,  3 Aug 2026 08:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785771807; bh=489LSWSROeDX5KUk3MIjI3VtRPQFNLK/zTNRdV4bN0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TGjmVsJe9jRHeyal17mELwW2sJe4wd2xa5agQgO9+Hw4b3mSsRVZQtg2JVaLec3SA
	 A01P7FhUoWaaRwNb1bh/FaFWzNCyF1ayL6GyEvMNAtmObiABH1bUKANNCk9dNkrCC1
	 NW+VR21MjlI1l8bvoek13uBZE6W2JrJCNSwAhcmc=
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: yangyicong@hisilicon.com,
	Jonathan Cameron <jic23@kernel.org>,
	"Pradhan, Sanman" <sanman.pradhan@hpe.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yangyccccc@gmail.com,
	Sanman Pradhan <psanman@juniper.net>
Subject: Re: [PATCH v2 0/2] hwtracing: hisi_ptt: Fix reset timeout handling and clean up trace start
Date: Mon,  3 Aug 2026 16:43:17 +0100
Message-ID: <178577175151.2908939.9759004338936788339.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414172451.14331-1-sanman.pradhan@hpe.com>
References: <20260414172451.14331-1-sanman.pradhan@hpe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 14 Apr 2026 17:25:03 +0000, Pradhan, Sanman wrote:
> Patch 1: Propagate the DMA reset timeout error from
>   hisi_ptt_wait_dma_reset_done() instead of discarding it. De-assert
>   the reset bit and log an error on timeout. Move ctrl->started to the
>   successful path so a failed start does not leave the trace marked as
>   active.
> 
> Patch 2: Remove the unnecessary 16 MiB memset of trace buffers in
>   hisi_ptt_trace_start(). The driver only copies data that hardware has
>   written, so the zeroing is not needed.
> 
> [...]

Applied, thanks!

[1/2] hwtracing: hisi_ptt: Propagate DMA reset timeout in trace_start()
      https://git.kernel.org/coresight/c/de24536e7672
[2/2] hwtracing: hisi_ptt: Remove unnecessary trace buffer zeroing in trace_start()
      https://git.kernel.org/coresight/c/3d92b39c5faf

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>
