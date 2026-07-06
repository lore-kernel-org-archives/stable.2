Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC06C27EFE9
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333519; cv=none; b=K6/hmFHytR7eD/NdDjQD5hdowNMSGQOpRgwJjQo4C7riCWdRJ2bKbdhOyF6/5+PQB+BAJOMiH8BLdJ5lkiCiGFLwwtNkJC0eiSnBkHCyjTLVK1GzZeWt+tj6sPfEBhPULXrwwTFh9Y/VD+fl25g63QkIflXGlM5FaiSHBkKbqdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333519; c=relaxed/simple;
	bh=DEDRVzDaeKVLrZDEM4Tvl5Zi+XQvdZFjkOH2bi8Q7O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkkUn5j9NDhwdlGnX1ANvGz/vdgyt0ElMKQjvKCSEMdTSX8tALqg4HTVb+7jo/zipOs3KsoqP63cPvu+0d5K5wdYVyRlAt3IVr0oR/zjomVd4QBpHYqI7T2IDxlk97gZRdpkmvc2tbxeW/vSxfP0RlnNKvdh72B6t4McOZBcVC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iMFR0wgo; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iMFR0wgo"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso886134a91.2
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 03:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783333517; x=1783938317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCyn3khAPieI4DeaZVrUFyliHAMCDDeM6OYmHqd4vok=;
        b=gwBGXA20cq0NCBf626utY/JWDyA40rVcQK/XYEGRN0kfehiOBL2M2OQU1SPTWrzD/d
         Cc7PeCsyLvQf+RXS8iweukn257LwMDLR5MtQM+zzdrhiNZD6RwZpKHhwoOWcckuY+xkL
         9EtiOmignyfzps9oGCOPHModBA1ajfMFAuZHNTUo3oxbe0qCU1RzsJPwpV0P+pkfPp3B
         SGfwvEsW87eTt6MpsHHm9+J5sPPtxpbof4WOCW9pvqnNGjohKUF/ySorN0wFMhzT26M/
         j4L8w0qu9aQO8YUQORFEzggihYdU3v6e+V0TJlkVsHtXjETVVEezX8q5JLhaD0RRrAlr
         3/cg==
X-Gm-Message-State: AOJu0Yz/e5rFi65KKw1c32SQ4iOFa96ohUBYi41DxK/ElW+mzgTMNuir
	8UwhkrxZhvE1v/eUzH4vE74J4HcGL2R2LSwg3ICE2tSxcpip/6rwW+Dorn5/z0JOANFFcyDBllz
	FsxDw9ZrLiJulOK8phtbwReQYYqJP8u7qby396htzRarHyHLdWhE80ZejJ7nNhZ+fAsAGQ3aFZM
	NKmBpmR1/tkYP/GwRhHkk0p4LKOA2V/pyQfhHlB2gDgY9TeJ0jj7R66MNwf2ALz9pL9SrVc/0Db
	RBDCggPpnn8ptbj3g==
X-Gm-Gg: AfdE7ckcgnZRnSmVtX0vB9djVRxJmlHdii2gAJzV8uZZYmt3E53iwaWD3osYA7uBfTa
	15Kwg3N0f7Q8qi8/gj1gRNSYtygfaaSKsWoj6Y+o6rgpvclwSNDopqw70Ok8KMm5Gc4waaqBxtD
	CzXsaBaoOuV2N4GQVFCdmdyiJ1JJLFuMhdmPq9ynG1UN2z/su1rC5HOxRUEBDO9WEKW99VBvpi2
	xxFggsZF61E5PVDRfo79T8F1eEZ4bmgKYDmqjAfE+uWVHYSkTPvHr4eX02ODxyTR42bHOtFVqay
	RduYmVjdijEmiohXLAdcE55ONcxrcqSMNQ7K2s4HHy1ht33/h0v7xb6G1mnCFqqGEwbCeiRNX8L
	WPeCbjA++sgfivOd0aq6eRdrHyWliYjLGZHzkrAy/OHj8B0vV1z7buc0KZDsHzox0qM0bAIspFu
	AM/zuBZdy4ZgSFHxhbdmkniEyI1OuETig7GSk47vIppY00G1gUgQ==
X-Received: by 2002:a17:90b:3c50:b0:380:fdb9:d2ea with SMTP id 98e67ed59e1d1-3829f0072c4mr10419224a91.17.1783333517143;
        Mon, 06 Jul 2026 03:25:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-38127ae2eb9sm817762a91.1.2026.07.06.03.25.16
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2026 03:25:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e55721a8cso270900485a.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 03:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783333516; x=1783938316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCyn3khAPieI4DeaZVrUFyliHAMCDDeM6OYmHqd4vok=;
        b=iMFR0wgo/l9eKgO++QclujbRbIQ0llwJAf07oEC3GEtInz/WWlMY6WZAy1y4cVGdlm
         6l1APWX9sUKNNtY7iXAoC5HXmYHmfYWN3PD+SPned10ZcZACCvP+Uv+zm+Uc07gSNUSs
         u6BnKHoM6dkGfGiMlZGtDUXPVzR49ONbv0yLw=
X-Received: by 2002:a05:620a:4442:b0:92e:5856:bdcd with SMTP id af79cd13be357-92e9a49ed00mr1318061485a.53.1783333515894;
        Mon, 06 Jul 2026 03:25:15 -0700 (PDT)
X-Received: by 2002:a05:620a:4442:b0:92e:5856:bdcd with SMTP id af79cd13be357-92e9a49ed00mr1318058285a.53.1783333515309;
        Mon, 06 Jul 2026 03:25:15 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b804ccsm900041985a.10.2026.07.06.03.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 03:25:14 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Robert Garcia <rob_garcia@163.com>
Cc: stable@vger.kernel.org,
	Duoming Zhou <duoming@zju.edu.cn>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH 5.15.y] wifi: brcmfmac: fix use-after-free when rescheduling brcmf_btcoex_info work
Date: Mon,  6 Jul 2026 12:25:12 +0200
Message-ID: <20260706102512.1429947-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528055431.4124445-1-rob_garcia@163.com>
References: <20260528055431.4124445-1-rob_garcia@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Thu, 28 May 2026 13:54:31 +0800, Robert Garcia wrote:
> From: Duoming Zhou <duoming@zju.edu.cn>
>
> [ Upstream commit 9cb83d4be0b9b697eae93d321e0da999f9cdfcfc ]

[...]

> +	del_timer_sync(&cfg->btcoex->timer);
> +	cfg->btcoex->timer_on = false;
>
>  	cancel_work_sync(&cfg->btcoex->work);

The upstream fix uses timer_shutdown_sync() which prevents the timer from
being re-armed after it returns. del_timer_sync() does not have this
guarantee.

brcmf_btcoex_handler() has three mod_timer() calls - two in
BRCMF_BT_DHCP_START and one in BRCMF_BT_DHCP_OPPR_WIN - none of which are
guarded by timer_on. A work item running between del_timer_sync() and
cancel_work_sync() can re-arm the timer, leaving it pending when kfree() is
called.

If the mod_timer() calls were made conditional on timer_on, setting
timer_on = false before del_timer_sync() would be sufficient. That would be
my preferred fix. Alternatively a second del_timer_sync() after
cancel_work_sync() would also work.

Also the commit message still mentions timer_shutdown_sync() rather than
del_timer_sync().

Regards,
Arend
