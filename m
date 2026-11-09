Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794207957;
	b=iEJAmk8QxvfsKIEGU/nGqCkIGtX5BnJMayPys4DjI3urN+nzIColdsLPSc4D5uELE98S
	 o4dAQjPFgzG7HxhCFHYn3nhMyfMM+JNpyqMv3wSxcGEk4WW0yViu21oLR6nbFE3uoW1kQ
	 VMYWAxMUx5xBSJNpZ2be8HtoC4+E6xQLDfpRJN3kEVgdTorWZ2qbwyfHmqSTQ+4lb9jAB
	 tsoFcxKjlcpuobH4RLDsmdxcGWXw2FEutZsLFM4RSFVoWUKqCakd56PJBNKMxGUcPiHgu
	 DOi3Ed6VaqYHTcfJYaHsqbTjJWjjIMPraSfIOugNAVuUfNPoxzUVExL3vrpghVnY+Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794207957;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OKfqZDRl0RoDQBoecXTPx+ATvrtGl86vakqk0+6hBNk=;
	b=Q4Kkq5ZcLY2onMvegmX5TOste185G50P5CHvS5a2sW7hfFH77n1XtRtw4mJl9uQHmDAq
	 URMivMXSmzOPBxMUhVy/KyVcTuxsUwm6F2PF2k1bjya9PDpGFoesxprxavVkUundngSHX
	 etWs5S+zf0GMkIzSzWtGtclPN4U6tj+kcay8CANE8dOEALMG33qbL+yvj8h44ddcRqtT5
	 tR+K8aG4mSbn2EtnvAAoamq7jzU/iTz/5eB6F/gfTy8Q9+Mwm6KqSh/gnLdxyDW3R6XM4
	 T28B29oy/XA1/T/D/68lnLKjl8QWfbczR92kfiKOwWltvY62jCU+L6RwJTJYjJb8mkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WJB9BMq+;
	arc=none smtp.remote-ip=91.218.175.136
Received: from mta0.migadu.com (out-136.mta0.migadu.com [91.218.175.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8036606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 07:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8036606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WJB9BMq+
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OKfqZDRl0RoDQBoecXTPx+ATvrtGl86vakqk0+6hBNk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794207952; v=1; x=1794812752;
 b=WJB9BMq+fFhU13B3Sq0B4aMa4tfkj9SriMLLJ9oGbdbyajq5NvOEkpzysKSpI23zh/t4DzKn
 wjGbuVN0bZQ+wmVPANnnpDpVYkUwNba8AjXmhtLyLOGw9U0bP8bjP//dcyMYGuO/AEIewGUf9YH
 2UNbpgd6Fte8Kufe78KBFt88=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dde931c2e3d2607a;
	Mon, 09 Nov 2026 07:05:52 +0000
X-Mizu-Trace-ID: dde931c2e3d2607a
X-Migadu-Flow: FLOW_OUT
Date: Mon, 09 Nov 2026 08:05:48 +0100
From: Luka Gejak <luka.gejak@linux.dev>
To: Kalpesh Solanki <skalpesh942@gmail.com>, pkshih@realtek.com
CC: kvalo@kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_1/3=5D_wifi=3A_rtw88=3A_clear_RTW?=
 =?US-ASCII?Q?=5FFLAG=5FRESTARTING_on_stop_and_start_failure?=
In-Reply-To: <20261108142708.489067-2-skalpesh942@gmail.com>
References: <20261108142708.489067-1-skalpesh942@gmail.com> <20261108142708.489067-2-skalpesh942@gmail.com>
Message-ID: <CEF516A5-5E4B-42E2-BBEE-6FFD89BC5B90@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On November 8, 2026 3:27:05 PM GMT+01:00, Kalpesh Solanki
<skalpesh942@gmail.com> wrote:
>When mac80211 stops or suspends the device without WoWLAN,
>drv_reconfig_complete() is never invoked with
>IEEE80211_RECONFIG_TYPE_RESTART. If firmware recovery was in flight
>during this transition, RTW_FLAG_RESTARTING remains set permanently,
>blocking all subsequent firmware recoveries until the module is reloaded.
>
>Similarly, if rtw_core_start() fails during drv_start() in a recovery
>restart, local->started remains false. When mac80211 cleans up via
>cfg80211_shutdown_all_interfaces(), drv_stop() returns early without
>calling rtw_ops_stop(), leaving RTW_FLAG_RESTARTING set permanently on
>hardware that failed to recover.
>
>Clear RTW_FLAG_RESTARTING in rtw_ops_stop(), as well as in
>rtw_ops_start() when rtw_core_start() returns an error, ensuring the
>driver always exits the restarting state on error or teardown.
>
>Fixes: 5c831644e1f4 ("rtw88: handle and recover when firmware crash")
>Cc: stable@vger.kernel.org
>Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>
>---

Looks good to me,

Reviewed-by: Luka Gejak <luka.gejak@linux.dev>

Best regards,
Luka Gejak
