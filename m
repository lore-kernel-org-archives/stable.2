Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5B0301704
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 06:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096538; cv=none; b=D1BPyLUTcFq2QxK8JsREiFiEyRS06X+RJUe3BVbuqKkM7QNmwpHIXPaLN8WP5pFbHoU2a58Gy8HtX2GqiiW8XwVuQ0id1ah+MVqc4hC5CzsLTyCb9XemGSvKXtIMC1c/vYQhzrb9yYIAR3SrQmo/PBymX+fMGnAD9fCEJ4+cbg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096538; c=relaxed/simple;
	bh=tMmYPuHq1TlWdikDZSCv0oAeVAd1+jF9vCMR05MaJYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdntC8mvGdSbBQ4h9UM9cx+JwuNXW8txkMSZfFBDQs0QogcbnKRIUzCAKWsfQ9I4ys7wMuhmFNHuUNeMbP7N6KSXwp4HW7G5mpIgQtuX3r2mZWSEQvUL9zuKWciMGBTTDWuASzjIox3BfV5kKiUs2P+4WLHAChhEVOBnnKTpTD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=akO7I3yK; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b="akO7I3yK"
Message-ID: <afa8dd4e-eac0-47f4-9c08-c9fd278a37a9@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1784096531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7x/HPKlo+USj4BpsCmStRoC33Qynj1Q2IqK9qpyL+F8=;
	b=akO7I3yK/m5XvQrsrf5PnYfovBMoNkXOcdfYCan/l/C0DM3AXYmP9lkvxcsiBoGKPMiZca
	tjM7qEKANLCSWyW84LKBRnDgyYp+5qy9mneJ0T2F16zvBi2N8uiKDie2QVSQT/+PW9xVyj
	bQU5fr3kdlh6fmTTouO1LP8uhc2by2eNpd/K33h25nMDSrEnqGcs+o9Zo/RKyXav9pBrlR
	+eRs0o+MVFfZzIWGACcXScEr/ArVLkQhZ0MTIGPsbCIXkxD2GBworMdAwCuyZSivc8pxci
	RFFCyrR4iurkO4PVDhi/op4iqePnf8oX2QsLWKT8DR+jQ1bbeaKk3MqqDDZ1Aw==
Date: Wed, 15 Jul 2026 14:20:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: FAILED: patch "[PATCH] smb/server: do not require delete access
 for non-replacing" failed to apply to 6.1-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linkinjeon@kernel.org, stfrench@microsoft.com, stable@vger.kernel.org
References: <2026071409-clamp-reminder-aacc@gregkh>
 <b5901dc2-0d5c-45ac-a817-81e2a3934131@chenxiaosong.com>
 <2026071515-dutiful-anthem-39fb@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <2026071515-dutiful-anthem-39fb@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Okay, my team will do it.

On 7/15/26 12:46, Greg KH wrote:
> Ok, so what does that mean?  Can you provide backported patches for
> these branches?

-- 
ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Chinese Homepage: https://chenxiaosong.com
English Homepage: https://chenxiaosong.com/en

