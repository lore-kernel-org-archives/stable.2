Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705745;
	b=VfFa6Wy7YhwGBcQfRyw5TjpNn7kr+fa/Xb/459uMx5R1ay1WShISqA5Ldj/Xno+HHDdT
	 tjKbQLGqpfDeQ87gnySPtRDF0RX6S/eFOkxA7I33y7AYCPm2cAI79616df5+02VX+0kGI
	 JaPHSuGs7Z9ollMeK8HrEhjw/ANY/cxDKDULsIfoVqgMFqX2FWOc7cgihWaWcu8XWDqDU
	 Me/3VTZhW5hP0jPk+FMVb1V3MDMW2ntqKI7DuiW7hz9Ka0ErVECOY3AJpI80nhS1q4Acq
	 9qwor4JUnHKEuICA+8lxT9dsleNXSPwePjggbP+OKSjb/COquME6bk16hUxzvW5wcRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qa1Fr1ic+7dw5K+GkYsqx2aXPhAv1AnGBqdarsMvPfQ=;
	b=ilY+478jUaOW4AS+zUDiVAGeKMP4iFygHO5UAZm2KItvzEG9OnmMM5PKQIwqwTMl5wrG
	 1bv4pUZLdBHUcG3nKLQoINUm1EVVn4VRKzSws1kzjpxPVtB+ihH3bUaS+6SGBt1McJCD/
	 VSOq8ydK3djRAR3AZPdmKXGdLdhV5I4/fwB/GE7j8+OuocZ0WMxE2oK7K0yU5tBdZTsIv
	 +I2DfUrMi2dJ6QG4YXYCLWrbkAw3R8mMxivj23rr/1/Kb11mGSS2Tlo1SB//7/ElaOy/z
	 MKhDlx7aZ14kKavoiIDjrWYL/hI+uO2GQ11/BlUOlfEp0KllzbjOMWDUFXY4ntLA/DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=B6xSaKdB;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6935F606A33B
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6935F606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=B6xSaKdB
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b3a42a4bcdso3033976a91.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 07:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795705744; x=1796310544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qa1Fr1ic+7dw5K+GkYsqx2aXPhAv1AnGBqdarsMvPfQ=;
        b=B6xSaKdB9GurxyEl5XPkhgRx383fZevVQduVZmC86MWv382bjsTEtHbvVGgHN4Cznn
         4JSZJ81ag+eMbef5qkmG1EHTwPt1/D4GYkbNYl+b20Pv4J4wnJQGVnq40kjtElZ5UCnE
         yxT0xLW5tIIGRUC1T6ZTZzJz2XBXnuo3V4r3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795705744; x=1796310544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qa1Fr1ic+7dw5K+GkYsqx2aXPhAv1AnGBqdarsMvPfQ=;
        b=dJG/LvhU2skYyxxSaPWuSHj/AcNPd7ZE6IncXXXONw8a8YE9A6uwrEkmjB07Dz5Xd2
         hPU6R+koCOUFD3dxMLiyIGedRtf/xUD3sBLRjhexAnJYm5suHwqBQYNhLCoYB2j3Lrol
         OSUZMD8iFwjtXahGGHTHU382wuwqMmHiew99CsyMvuVs4DpkmRHSEdE9AqRgb0GYS6/T
         ZC7rwreNFglrQbdQZ/fVBoNIpUjfiLLdKo3pqxPcDRE6gFY1oat2wsQTCv82JufvlGM5
         22fAz0D6SaENtWXUeLPuaTEegKiG9IV004NZVzKDRPUb7JnJ0JdGcIoiVpDCiq9L2l3u
         nSMw==
X-Forwarded-Encrypted: i=1; AL+hErEuJrQr5isDJMtSWmeuG18HukQqzvF2g1NIu/smydjQK4dWx1BXpXCbNz2VzfBuLxli8UeaCWA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+F77874U3fWoFFRbpyM+Pfbo75vKd2LhGty2EINbTdjhaTn9Rt
	9QXQmofnCQjcqxQ7RgFUI3doNEYcHspXTkh5Gcpnlv6XfbFPvonXtEhqQWze7THAj92b8K7Dj25
	Ki/zv3ya2Dg==
X-Gm-Gg: AZFdTZdS/7tpMlI46cAn9rBdNUBUXJoIhfAODqNFi8tU7o9ljEh9jNd2RH78zmriP7H
	RFj6eoLmtkjTzgUGYCAR1oaNcwy+2K1N5HIWwq/DU7F6ka+tnXAL1TYFVNLgjiTXNL732dU1mai
	AapAWh22S1qrRcXgQQEe23cpp42MfBnI8a5A8T0oJkh/l1qRChZZrBT3VDve/q7XxzxIOOm7EYR
	ka/fDYHHwUnNhR/BHMDkR6CFtOxyp4OAzdP+bAqiVI+U/sHNl6vFSsDZ1L6A+dvODhbSU4lhvEt
	CQK1wI2dm12nWX+oEVLgUjxAHeZNu3U39eHQErdX38osEmJrA0bbFyoorvT8FM3ZF0NJ+0UmAXH
	nsAgkFp/pmI7wZTP20IxSOVr3HxOOxiSfvgNoRQooWMllsvSEWLGV1V3OlWUjlGe58pbmdNN9lr
	svhQVnFpqjJZmKlsOcvLsUEVcUROOOyonzBkXa3Ez0XcICdrqE7bvXO+HHiVkzmzte1WjI8/XQT
	Q6t2LicD/JpBjK/j2gEjLtHSzjiG6lAe8H9fKqG/gbarGwScmQ2dLzbGvY5sEjCa2oR9QXkleTU
	C6+2K1uitXRsAnaksRoSUydF09Xya/qQFDohGOsuzu6ct/rmwC7nHrjqv5gHnIBaHrvOH+INaLz
	T+P1vzjGwCaKxDVFfip+RFhdjZ2etaO+ERsUJ/bXQ7/sErChs0PeZOhI/oZa/bQLME3mI1MUcrK
	Dnchg9aHtNZQ==
X-Received: by 2002:a17:90b:2792:b0:3a4:ca46:840f with SMTP id 98e67ed59e1d1-3b41c8e172amr19036608a91.8.1795705743643;
        Thu, 26 Nov 2026 07:09:03 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb1b66sm34512681a91.1.2026.11.26.07.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 07:09:03 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kapil@presceralabs.ai,
	stable@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH net v3] net/smc: drop the connection when the peer's failover cursor is impossible
Date: Thu, 26 Nov 2026 20:38:56 +0530
Message-Id: <20261126150856.2116458-1-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <sashiko-outbox-233843@kernel.org>
References: <sashiko-outbox-233843@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you - all three findings are right, and each mechanism was read in
the tree before acting on it.  v4 is posted separately.

[High] premature cursor rewind before abort check

Correct, and this is the one that mattered most.  v3 ran the check inside
the fix-up block and returned 0 from there, by which point

	smc_curs_copy(&conn->tx_curs_sent, &conn->tx_curs_fin, conn);
	smc_curs_copy(&conn->local_tx_ctrl.prod, &fin, conn);

had already run, so the connection was left with prod behind
local_rx_ctrl.cons and peer_rmbe_space still holding the credit the forged
message produced - the atomic_set() that recalculates it is below the
block I returned from.  And the tx path tests conn->killed and
local_rx_ctrl.conn_state_flags.peer_conn_abort, not out_of_sync or the
local_tx_ctrl flag v3 set, so a send under lock_sock() could reach
smc_tx_rdma_writes() before abort_work got the socket lock.

v4 validates before anything is rewound and drops the connection with the
cursors as it found them.

[High] incomplete peer consumer cursor validation

Right on all three counts.

The bound is now the bytes that were SENT and not yet confirmed - the
distance between snapshots of tx_curs_fin and tx_curs_sent - rather than
sndbuf_desc->len - sndbuf_space.  As you say, that counter covers the
PREPARED bytes, so v3 would have advanced the cursors over data still
sitting in sndbuf.

cons.count and the difference are both bounded by peer_rmbe_size now.  v3
left that to smc_curs_add()'s single subtraction, which is exactly as much
as you describe: with sndbuf_desc->len larger than peer_rmbe_size, a
difference in between passed and left prod.count outside the RMBE.  Below
peer_rmbe_size the repair is exact - prod starts at fin and the difference
is their distance, so prod lands on cons rather than behind it, which also
closes the "halts sending" case in your third point.

[Medium] false-positive abort racing tx completion

Right, and it is the same line that caused it.  smc_cdc_tx_handler()
credits sndbuf_space before updating local_tx_ctrl_fin, and
smc_switch_cursor() holds only send_lock, so an honest completion between
the two reads gave a diff computed from the pre-completion cursor and an
unconfirmed from the post-completion counter.  Comparing two cursor
differences removes the mismatch: both come from snapshots taken together,
and neither is an atomic counter the other path updates first.

Tested on 7.3.1 with KASAN; net/smc/smc_core.o builds clean.

pw-bot: cr
