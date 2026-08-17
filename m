Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63A93E49D3
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787004706; cv=none; b=SGXNe0oezUXsD18stLvacA4PPFvjgYjrwgmmo60U72KBkOcUqvXopIu8ChvC+FuHv3tyd41iq0zO8xn4YgsgASHJTKhK02hAcp6OzYPuPAxNL/o32uSdsHNcqdgyvNHNLSJrNA17nYfDesHFnka0fQ2XvIUZC2s83FpI5jyvqi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787004706; c=relaxed/simple;
	bh=YnDmlU8c1/ZspkFjxk3gXdgJiW3AOD8WifHnjPoY9Kw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mOtoknn8NX1MQ3tbaOoqJ8HagYkCpB3A9chTSjkJ4hRlvfRW6gJxWvb14E060l+AQCUO/oa9h3JJ4MKHQpktUHCsYlInWKJmZ7dYe/x6H6yfwaM9qQ9kFcaV+TZYzBk++JFhvdQ8a002Rco+1MrFTwII/WOv3vaxEhxI3MaaQ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=T/L/gRUE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="T/L/gRUE"
Received: from vm-dev.d0aziqou4eyuzblxqhi51nu2sc.xx.internal.cloudapp.net (unknown [4.246.87.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8A8C820B7167
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 15:11:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A8C820B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787004676;
	bh=PtWj1skMeN4mxXWGtXcHVuySKvFPrKl+pomnxULqDcA=;
	h=From:To:Subject:Date:From;
	b=T/L/gRUEZQm7VRIbdG87gynelXCH0JCElVEjKnpzX4NtKHgJkTwKMhSdOA/26wsUj
	 +7Y6PdYdUse4/uWYIklZr2hhxsSudKnu9Ddf5iKyEAEoCksw7Zk+z8/rG867t7QGOJ
	 Psh35HM6id/tykihAt8oKs9B62Trv71NSvQLp2xQ=
From: Tahera Fahimi <taherafahimi@linux.microsoft.com>
To: stable@vger.kernel.org
Subject: Backport xfrm race condition fix to stable kernel version 6.6.y
Date: Mon, 17 Aug 2026 15:10:09 -0700
Message-ID: <20260817221108.778584-2-taherafahimi@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: taherafahimi@linux.microsoft.com

Dear Stable Kernel Maintainers,

I am writing to request the backport of the following patch to stable kernel versions 6.6.y,
addressing CVE-2026-31516.

Patch to Apply:
    Subject: xfrm: prevent policy_hthresh.work from racing with netns teardown
    Commit ID: 29fe3a61bcdce398ee3955101c39f89c01a8a77e

Kernel version: latest kernel version in 6.6.y branch

Best regards,

