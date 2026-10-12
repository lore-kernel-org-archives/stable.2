Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B304A091C;
	Mon, 12 Oct 2026 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820537; cv=none; b=P9pnZKEUpmsj4hDIMRJQMcD8walvXWmvov4LhsAinNAw9wwwouWdrJmrNONSByw2cW0VfDhPU1Kz1kYUuL6pUR8ffmw1+Iv/J1d2XOeZXKGIuPpVRJQ/lR99KiptPBxMLeior9SJlO8NZevA/+lEv+2B7fiBhAvZP4mvOAnYH+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820537; c=relaxed/simple;
	bh=j/S2wVFyKe4u9vae9EYzWsW7njS4kntD9ZteLiIBYGQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kz6aDeTScbqVZ53qnDS2XIpopIUgJeXFNRrcA/Ey5lNWmj7bsExmT1jJKxudvXo9cz2jOrLkKhr0Lzmyskxhfs8ocTqpU+VyeDsHFz2xk7xEtMFkmcr67PSSDbHFPqCbcJmN63tgJYPSbUb/CHaokaE1EfBvvYxvJC9PDr1NfVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ML9ecAhL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ML9ecAhL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791820536; x=1823356536;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=j/S2wVFyKe4u9vae9EYzWsW7njS4kntD9ZteLiIBYGQ=;
  b=ML9ecAhL8AyOu8edP95C9gBcsF4AUSLe7q8pJtuOQ4NXik0qWgX55aTT
   pMZZT8odo2TIhBhPE4mpaBko+aUKMpUuaf9S+xFQeFb5rVXJXLY0XSUjk
   UsO55TDYKrKwotq/RIGBHu1CDnSbWxG2JgKhdZX6BwiJ3Fw+oiv14bzbx
   4SqTIBN0D8GkBAueqbCGQYxexNJrs4lVZ/VDRzbBg5jxpb867P4pQCw+w
   UYjxd+D0hHK58bFvWYeibvK1Z817ulmJ4UXu15bw0HEWjIoP7mXf+ksu4
   KfeNNvehUW4b30iAZFpB0fQlFpIHmru1kzseigOR8G5yjvdq6e1IkfnvT
   g==;
X-CSE-ConnectionGUID: pmi6bZIuTTGLuCWLq3WGIg==
X-CSE-MsgGUID: c/c99PzqSjSS+v8Z2Snhqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="417076"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="417076"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 08:55:36 -0700
X-CSE-ConnectionGUID: mGel5f9eQHC0QCKy61WbSw==
X-CSE-MsgGUID: uPRMIt8eR3iDOh8ZF6bKfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="908774"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.202])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 08:55:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com, 
 Guixiong Wei <weiguixiong@bytedance.com>
Cc: hansg@kernel.org, rafael.j.wysocki@intel.com, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 wangyijia.yeah@bytedance.com, stable@vger.kernel.org
In-Reply-To: <20260929163133.14326-2-weiguixiong@bytedance.com>
References: <20260929163133.14326-2-weiguixiong@bytedance.com>
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Continue restoring
 limits on resume
Message-Id: <179182052851.17897.17290819093548641057.b4-ty@b4>
Date: Mon, 12 Oct 2026 18:55:28 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Wed, 30 Sep 2026 00:31:34 +0800, Guixiong Wei wrote:

> The PM notifier iterates over every uncore frequency instance to restore
> user-configured MSR_UNCORE_RATIO_LIMIT values after resume. Entries that
> have never been configured legitimately have stored_uncore_data set to
> zero.
> 
> The refactoring that split common and enumeration code changed the
> iteration from active control CPUs to all allocated instances. It also
> changed the skip for an invalid or unconfigured entry from continue to
> return, causing that entry to terminate the entire restore operation.
> 
> [...]

Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

FYI [if applicable to your patch], as per Linus' policy change, also
fixes are mostly routed through for-next unless the fix is for a
commit introduced in the most recent cycle or is clearly a regression
fix.

The list of commits applied:
[1/1] platform/x86/intel-uncore-freq: Continue restoring limits on resume
      commit: 8c1d61297a88cc7f7b2daab7b86c3e85639b46df

--
 i.

