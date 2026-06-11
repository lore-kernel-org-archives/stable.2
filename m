Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3F6375F87;
	Thu, 11 Jun 2026 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171840; cv=none; b=GbP0OAuyTFA2l2l0uWtEXgSZcGdfx9PjLo6NQTcIBRarSqPFGXAoBQwtK9lMFJd0EuI7PcgJ41hGi1oVs5Jle+OsOEl2xu7YHtjptlxIGoODu0sec3H11IlyItgFC8P2cZVCRulcyRc0R96f5tU9XlJAVrkWC0xYx2ILYl9aO4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171840; c=relaxed/simple;
	bh=Y4iF2arspFBq1Jv8QVwxqZvgeFBzKCiYqK4M2WzHJaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtAMvfhMUsp5I6oDthINkBdgWETDuBCDFf7LoVRHFL4EIBzL1qTOUMeZwxxBgtKoFK7oBZZ/RWgZvrDIDNZ0YapIiZlSorWdu0H61ibyIc2oJRgK19udENfQiD3BUgJFxo0M1lTBdHQkKyol8POEn3ups0dkfeV52h8/6uO1Ws4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TnCF/Ye0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TnCF/Ye0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781171839; x=1812707839;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y4iF2arspFBq1Jv8QVwxqZvgeFBzKCiYqK4M2WzHJaY=;
  b=TnCF/Ye0TgNiqo4iylqOTrTpqAwdbnWMZdGmyERCZ9Qe47vZacu0xLlk
   2PXuwc4R7F2T1hA3SSiH5k24jg62ZpX+16FMa6RItaiYRWqczpJhsMnnm
   apkDbc/pkqrnjfcIfXFtk8rLjMJFnL1SVPmr3xEs4j0IvTlOXCKr0N/vK
   SjPyVimFToBTLkxkPmqav41qYQA+vGtjfCHuemfNS7fTgOrfxg0be244o
   aQSPNzTdKV8soSTFNCGbggZcRhPmUs58ZZE9dyFJ6BPxnh9ZA824NROFf
   WZ2zK+78RRo6ANJSMDvpZ4p6am/f+qqtmaat0OgxgcOI6oK7mo9Di9c/L
   g==;
X-CSE-ConnectionGUID: u5ITvjaIRzqIHxpgGV6/9w==
X-CSE-MsgGUID: n+Ne4BrsToSwXC+fVtEKKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85878381"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="85878381"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 02:57:18 -0700
X-CSE-ConnectionGUID: dzsk0NkGSKeWXfX6TsWfuA==
X-CSE-MsgGUID: cFzqVN17S1yy/u5AokpLMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="248307637"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.245.113.42]) ([10.245.113.42])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 02:57:14 -0700
Message-ID: <97cdf8fb-8a8c-4d14-aee6-cda196d22c85@linux.intel.com>
Date: Thu, 11 Jun 2026 11:57:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix memory leak in
 ice_lbtest_prepare_rings()
To: Dawei Feng <dawei.feng@seu.edu.cn>, jacob.e.keller@intel.com
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
 edumazet@google.com, intel-wired-lan@lists.osuosl.org,
 jianhao.xu@seu.edu.cn, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, przemyslaw.kitszel@intel.com,
 stable@vger.kernel.org, zilin@seu.edu.cn
References: <00f5f6e3-e80f-4c16-8d2f-f8148bcddfa8@intel.com>
 <20260611020254.308446-1-dawei.feng@seu.edu.cn>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260611020254.308446-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11.06.2026 04:02, Dawei Feng wrote:
> Hi Marcin,
> 
> Thanks for your review.
> 
> On Tue, 9 Jun 2026 at 16:27:20 Marcin Szycik wrote:
>> IMO last two paragraphs should not be included in commit message,
>> rather after ---.
> 
> The reason the manual inspection and testing commentary was placed above
> the `---` line is that we were strictly following the example template
> provided in Documentation/process/researcher-guidelines.rst. 
> 
> In the researcher-guidelines[1], the example explicitly places the build
> and hardware testing disclaimer before the Signed-off-by tags, which is
> why we included it directly in the commit message.
> 
> Please let me know if you would like a v2 to adjust the position of the
> mentioned commit log details.

Thanks for linking the docs, now I see the commit message is exactly as
recommended.

Thanks,
Marcin
>> Correct me if I'm wrong, but looks like unroll order is reversed:
>> ice_vsi_stop_lan_tx_rings() unrolls ice_vsi_cfg_lan()
>> ice_vsi_free_rx_rings() unrolls ice_vsi_setup_rx_rings()
>> (was reversed before this patch too, but since we're fixing it, might as well)
> 
> You are right. I'll update it in v2.
> 
> [1] https://docs.kernel.org/process/researcher-guidelines.html
> 
> Best regards,
> Dawei

