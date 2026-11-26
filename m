Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705594;
	b=2aVsgc6V6iDSgx7h2X8N9Dj3S1ICCGUwGyyusDtQ25JpGqMsggiKYLoS1Kd82QVLabdF
	 bwna3uYT+aT3op0cQmd9zVnkvNfjnZUCPKXqRg+1GlXdTTNzOAEMa/rn2xy8JhLAaNsCr
	 mW9llRXyFhyC8Uu4de9HhRVdM3ZDuixEWZlKMMZ8a0PPbxjYA1d7iph7LgEPDQ3bV8mGU
	 TjgOAPwBQnwBi8lIR6JAirt+HlLF7s/vl6DPOMlxmaVBcBu2vPKzr418/VEWK39ma5MxJ
	 VoUP+XADbMRurWcEp61lXJAv84AQauAyP2v04LiQFpWBOqb2A1oUNV5IfTb9y1vlg8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vFxzL6N7fV5dEdD6E6EPpo4S+xvEUTNbT1G/ro5XjSQ=;
	b=O4/vZ8mB9M5qVwx5ss2cNA0zUIdyPa+D7BGV99hhCbNWUzIYrQjCCwNDRN86RqIxNzeM
	 r6TfF0vlYrGFUbKAVFCGzocIj+3Sbn3NIB8mBkDb/dwOH1Jka3nLA2E1FwhcUPveprjA5
	 dh+GDtIP+zO/4YdjCOLzCyJbYCZqzlpLxyqnNyqdgt9JhjptWub5cIydKF1b7U+48f6DN
	 mnzIrEkV4fpugsgrjkVA3sQxgFgqeBN1MNCZGrz/dYXyfjwTvzDSTCzBBsOJzQZlRwVgi
	 nJm5wUe+ASVb47wPm5e34ogG/6289+M4JIEdH0GdwrKck0xjVE9ZvTuX5buAb2NXoBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=cyj1fHpi;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875A1606A688
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 875A1606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=cyj1fHpi
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cde5a7d79b0so3648428a12.2
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 07:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795705593; x=1796310393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vFxzL6N7fV5dEdD6E6EPpo4S+xvEUTNbT1G/ro5XjSQ=;
        b=cyj1fHpignlDujJCnViGY8sX6x8wogPXBpBDbUr/XIdmWpWrKtxMFMMCszkNH5KK9U
         C41GxztehbjKMlbgmqYxIdLHn2VzjSTutkCUPcqXt+TEJt64BDjWklhaWCq3SZDfnOX6
         KmhhKc5hkKYtcCSsx4GDGusu3eAXwjUr5s5bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795705593; x=1796310393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vFxzL6N7fV5dEdD6E6EPpo4S+xvEUTNbT1G/ro5XjSQ=;
        b=YJbsgqTzBs2C7TaJiZ+M2o2wE5Vyvve/84z+Sx4WtOQ5VeJlZBx/Lx4SUDJyISPDjg
         LMFpTMZ1B+nY+YfatQh1ltCnTAIFQ3UJ9J8SSPUMyJ/jSqo98Z2tnJPlnHmCjQulS0rH
         YUyg+WUZuCmy6tqZ8PCFOM/o4i7N+nqFYjWov+ttJppau+CoSirhaWn2mtLuUaWjw1Qq
         OtiTaCfocIgymf2gWjGFZjju96OTCqJ3VwTRkOjfYika5Xo/SuA4knXtiNjRgLQjd+GD
         ALINB6kYd7hGszbqfORyTui+ky71kpXC/X6QIijxXJAVtZZgxJp59XVjrRse2lT+GpAr
         k6NQ==
X-Forwarded-Encrypted: i=1; AL+hErGJ14xoDDCyTb0fg/8Tf566lPMy3VlDyylYSAPtCY0a96gbfZtBnM6ukpWw0uLHJJEVvsh5TJs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pXri/2uKbsll7fl+GecOu4xHKMBqvKyLz/s8GANaMqu8uKT6Y
	v61uD0v/btyiE5ldisNenVjgGfeWigPHlxMpTIR2TFJ3LVrdUS+hB7xPRJUrmyXO9dM=
X-Gm-Gg: AZFdTZcGspmw9GFjUFrc1LtnOQdEqqN7vD9UfpfdHI6VtZ95D0Ldnc7ZfENlX+i+Rat
	goADovqmFoJwrn0/AF2teXA2c6QQwJ43hxeqvg3Of6kC4zmErP+nH/1KgwJzoYMaBLZik1c7iZD
	LLdlt77wUBaQo6XWo5bk+9FjzpI3NNs5pHGWTkMMX3g8FjzqyGs3YXy6usuhD/nxJlf+ieXT3b7
	VlDbYIMXo35iGUCM1QPrKm4Ng/UJFFwQn+w2Y9bOsEpbRVE1fX6P53agCIh622F7ZCqcyrrOW/a
	mlnK9utKlp/pxg/izLlLGi2xgwcqvohrvsJ0eGKT79SbVh1xu5RG0uZhYY68eaguwTcTJHFgk+f
	EWmZ50zLHJgOL5Ykug326GwjX9crGCNzhI1Gal3cy39KRUAOyE0liP/Gzlankdgm/APaxj8g/0t
	YTIXJu2bMHF9lTXCYsLVBmmvmV/19pDZO22El494pPc4xD6yI3CLpKR2yRm4+ZrKfcZTqpp4p1j
	/VU+Xh0W+NYXhhBygyb/Mou1OJ2XE508pp4VZjUD8KZkAZRcS9gD7UwkWwRLdmG+AhbSTNuh3gq
	UxvVaM6Qq6DvOeJxf0aexEbyYpwy3ivYYOI6v00gklqnf78ttQT1D6XHwNlDGEfa4ZS0mSoC5E2
	oLvEowcWeql2AnGyH9UzHN3LlMCCrlJYp0+WihbCxL14XR41icRJ2csx3r2IwQnjcng==
X-Received: by 2002:a17:90b:48d0:b0:3b3:b5b8:1f43 with SMTP id 98e67ed59e1d1-3b41c97115amr22991604a91.62.1795705592804;
        Thu, 26 Nov 2026 07:06:32 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde84cd5ed8sm8039585a12.10.2026.11.26.07.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 07:06:32 -0800 (PST)
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
Subject: Re: [PATCH net v3] net/smc: bound the DMB-nocopy send-buffer credit by what was sent
Date: Thu, 26 Nov 2026 20:36:25 +0530
Message-Id: <20261126150625.2113302-1-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <sashiko-outbox-233892@kernel.org>
References: <sashiko-outbox-233892@kernel.org>
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

Thank you - the finding is right on both halves, and the remedy is the one
you name.  v4 is posted separately.

[Medium] torn cursor read and non-atomic update in
         smc_cdc_msg_recv_action()

Confirmed.  smc_curs_diff() reads wrap and count with plain loads:

	if (old->wrap != new->wrap)
		return max_t(int, 0, ((size - old->count) + new->count));

and this path runs in a tasklet under bh_lock_sock(), which does not
exclude smc_tx_rdma_writes() advancing conn->tx_curs_sent under
conn->send_lock.  So passing &conn->tx_curs_sent in place can pair a
pre-wrap wrap with a post-wrap count, exactly as your interleaving shows.
Both outcomes you describe follow: the difference collapses to zero and
the credit is lost after local_rx_ctrl.cons has already moved, or it
exceeds sndbuf_desc->len and the bound does nothing.

The second half is right as well.  smc_curs_add() is

	curs->count += value;
	if (curs->count >= size) {
		curs->wrap++;
		curs->count -= size;
	}

so in place it sets count and then wrap with plain stores and transiently
leaves count >= sndbuf_desc->len, where the code it replaced wrote the
cursor with a single atomic64 store through smc_curs_copy().

v4 does what you suggest, and what smc_tx_prepared_sends() already does
here: it snapshots both cursors with smc_curs_copy(), computes both
differences from the snapshots, advances the local copy of tx_curs_fin and
writes it back with smc_curs_copy().  The cursor update is one atomic
64-bit write again and neither read can tear.

One note for the record: the torn read is not only in the line v3 added.
The diff_tx computation read &conn->tx_curs_fin in place before this
series, and the snapshot closes that too.

What is bounded, and the bound itself, are unchanged from v3.

Tested on 7.3.1 with KASAN; net/smc/smc_cdc.o builds clean at W=1.

pw-bot: cr
