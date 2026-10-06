Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5772874E1;
	Tue,  6 Oct 2026 00:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791247812; cv=none; b=TDqNJ1k8q4ZQSPcetCnLVoWwWHgKVUJSrT1FEPOvTS33CIkksZ1wlMQr+DOXbCw2E/B9XHsiWoJFoRytgwsf7DC/d209KkSP3PRExJ3zZfmgIf5M7LCF5Dyo4tNb2HlfiUo5NcofmX5YZxUODutXvN6/Wl+qQySHyC2TE+kT58U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791247812; c=relaxed/simple;
	bh=/yoNWR+sE5eU1cxdfMD1qj7e7Iz+HdN2ajbRTz4oGxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I7grOi4HdmssQWes/H0A6ItRlYuLd0F8bnRg21O8pCo9OPqUf+4CLxtFz4Et8XaYIcsFf0hi2VWwC8WVIop0xqCvquFlYHD7fhJ3zRuLW+p6cctNr/5IgPAq7QNYgH/hwihpRh36D1mN00hJl5C1Aaqo0duZz+/OWLuli0kE4uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0Lr76Tp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0Lr76Tp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823731F00893;
	Tue,  6 Oct 2026 00:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791247810;
	bh=Ks1YiFjzmFe+TYdtd7qMf4vRgvWQQXYIm6im8ZHjyzM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=C0Lr76TpguBsL71RnQtuLT8F5R6T78ebV+ljuFPAb9u/NaayyCXQR21DqyAdMN5KH
	 u5qlvlhDgF1AxcrGHusTwfsTn7p0uMFU+y9CTQmF+CXwZNM05zgpqNUbs8DyfDCKBc
	 KTvpX8DV2ricUW/D/aRIMAuxxSExvZQ2uvwx89mgnkeRrCMjewybqtdMmJBc+624HC
	 N1L44jK0GtlRvHcsTblTN8qyt5TNjnsqdciJDleeZ70iHvySTuLkQoMZLf0HN2OqlO
	 PXE8on2zZ2zpZSOFV/Z9Qa8+lMc9hatjJHMWpj19dvCA2Do5IXWbB4ItGV0CWd/67X
	 QE175vjuF05AQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77446392667F;
	Tue,  6 Oct 2026 00:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] net: ngbe: fix error handling in resume and
 open
 paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124780902.1960739.16366418673480841555.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 00:50:09 +0000
References: <20260930094748.1198085-1-zhangyunfei1@kylinos.cn>
In-Reply-To: <20260930094748.1198085-1-zhangyunfei1@kylinos.cn>
To: Zhang Yunfei <zhangyunfei1@kylinos.cn>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 mengyuanlou@net-swift.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 aleksandr.loktionov@intel.com, u.kleine-koenig@baylibre.com,
 weirongguang@kylinos.cn, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, leitao@debian.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Sep 2026 17:47:46 +0800 you wrote:
> Two error-handling fixes for the ngbe PM/open paths.
> 
> ngbe_resume() declared err as u32 and returned 0 unconditionally, so a
> failed ngbe_reset_hw(), wx_init_interrupt_scheme() or ngbe_open() left
> the device in netif_device_detach() state with a broken interrupt
> scheme while the PM core was told the resume succeeded; the reset task
> bails out on the missing netif_device_present() check, so the device
> cannot self-heal. Patch 1 fixes the type and propagates all of these
> errors, making the whole tail of the resume path consistent with the
> pci_enable_device_mem() failure path at the top, which already reports
> its error.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: ngbe: propagate resume errors to the PM core
    https://git.kernel.org/netdev/net-next/c/6986ff35f5bb
  - [net,v3,2/2] net: ngbe: clear DRV_LOAD bit when ngbe_open() fails
    https://git.kernel.org/netdev/net-next/c/7b36b48049f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


