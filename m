Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9271B41A4F5
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789497295; cv=none; b=Yx/4j0dQ/H6n7r7RvxCJ0+QJSQj2GCqcl7lyAtPleX53AZAuA0w21bFoCDr5wQJqGg/4gDCw0hFbRG3U7fNS6DRr0Ni52BCjNAYqpqttDKurZil8M1khaSdsaH1+eFNQRPw/TvlV+xRB6y5B0dONx8mSacd+CiAh68urGiQCtdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789497295; c=relaxed/simple;
	bh=0yd6jT2VY7pX8vQe4i6Maqogt0pY64Z2hrVmFn/RsxQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=kIhIzIh4zXPgL026S0ZoaxeCfRTGJQMWyforK2Mww9FDTdGpEnPQZEqBXhG6ORXx+GqYr67komJxHElAf+yR1J8lXZIaJ4VWS2wTPzx8DbGl9AtdiSPBZzkHlOEM/Z2wvAkJ/kyTPiPlZluVe6cnWA822F/deLiESrXh5IZvdI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=MVDS9odF; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="MVDS9odF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=gAMUoWS+/1EAzjfxC8zqAN5ZAhnISP8H6sp4TSxNLvM=; b=MVDS9odFIPygjM6OnRjc86LPjK
	ngRA1hiigj8rVWIwyE8dnehj+FvQ5v8+yN9Kq3hkPzpdEfzaHCqZzDSeC/ToZnOUsqmjf2FZtwX+P
	uDYm7BLlL/vBaiPqWt2PZWPuG7CrbYtSKA/rfzz1aoUlFxNwHJA2Q6nY664TYJQj7fFqtejW+V+/x
	PnOz7Gj9TyQXmaZ/0wOvTaaAAbCgpTrrCSj1vu38ngSkqRxP/+Ge08lukksh09hUTJ5mUSSjskeQk
	nSJmKOg5dFHKbOmGgJwG/UAnEbfyPfSmJRsTQDoMzjCsu/ytJE+ENn2bPoAFuXfsyj4PlCpV26YBU
	M7RX0hBA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1x6XJ9-0000000AY1n-1Unl;
	Tue, 15 Sep 2026 11:51:03 -0600
Message-ID: <0a0d0a13-5e13-464d-934b-39ff98bc1deb@deltatee.com>
Date: Tue, 15 Sep 2026 11:50:46 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Fan Wu <fanwu01@zju.edu.cn>, jdmason@kudzu.us, dave.jiang@intel.com,
 allenbh@gmail.com
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260909145554.704036-1-fanwu01@zju.edu.cn>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260909145554.704036-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: fanwu01@zju.edu.cn, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, ntb@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] NTB: ntb_msi_test: Cancel setup work on remove
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-09-09 08:55, Fan Wu wrote:
> The MSI test client queues setup_work from the link event callback
> ntb_msit_link_event(), which the NTB core dispatches whenever the link
> comes up. The work handler ntb_msit_setup_work() recovers the client
> context with container_of() and programs memory windows, scratchpad
> registers and MSI interrupts through it.
> 
> ntb_msit_remove() never cancels the work. ntb_clear_ctx() stops new
> link event callbacks from being dispatched, but it does not drain a
> setup_work that was already queued. After the remove callback returns,
> the NTB device's devm eventually releases the context, and a
> still-pending setup work can then run and dereference freed memory.
> 
> Quiesce the callbacks and drain the work before tearing down the
> resources the work programs. Cancel the work after ntb_clear_ctx(),
> which guarantees no new instance can be queued: link events are
> dispatched under the same ctx_lock that ntb_clear_ctx() holds. Do this
> before ntb_msi_clear_mws(), so a late setup work cannot re-program
> memory windows that remove() has already cleared.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: a6bed7a54165 ("NTB: Introduce NTB MSI Test Client")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

This makes sense to me, thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
