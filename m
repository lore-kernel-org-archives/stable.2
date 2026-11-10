Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289454;
	b=GuYEG/IAgBy6PAoFGD5kLLwD2YJ7kQ+D90mkCyyuB413SB2KoDfWQLnV2OCst/1IYU7f
	 zwQTRKcooHZ31oa+/xQMrApzrXHX+O99By8dW67NuJSnEstLTA4K2MwsQ9LoxQMjV5K5/
	 o/loOHBN8WSjCA6RNpmvKtnsvvcAebfWGBXC9ITtmDPkEB8OYqvYFhRPF8iQtC61D4c++
	 /2knDwbI2EyJL+I/zz1VRdg1l/bZImkOpYn0O/3OU1VU9doNaquxVcmRbUEDQMm6aOyR+
	 UDRvCNouS4AgFF+V3hEjqGYBL/MlzEBUKtbcyTIL4wxqCnQfdUwDm0z+/wDQnYM906A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9ljX0hqkFpVdDO4bWmsipvvF8GC2kb5FdkDBtLth2A8=;
	b=4oZfdwIUA6aJRDwHW5u29NTkxmkRY118drQ0gTiDz46MCTg2w8cAcsa3nzfG2K1Jd3SX
	 YiUyHjTRZEUnwbOdk6Bi54W17zO8Y7oqAoft6NSjUTIuWDLWQNkrGfJso95Se8/Ga45yo
	 rYMdEUCf4NV3BX2zva4YaLoo+9U6zAwMdDtDVKY0dKOzNdR0IKqpYjuDJrihwei0kcu94
	 zUOiGmBa+OQlpEmO4B1PEo55DKpPgX1QEYIq5hRUun3OK9b9dFvbuFTYVjJ+kT3pz/YGv
	 koWaODSLuFnR98cKThq2OAgrYvplMFLcz2bwk0Pwpr4KCjYIHWutV810nPCSLCe0GVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=RhJ++tfx;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AEC606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80AEC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=RhJ++tfx
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6de1fd5f572so619294eaf.3
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 21:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1794289453; x=1794894253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ljX0hqkFpVdDO4bWmsipvvF8GC2kb5FdkDBtLth2A8=;
        b=RhJ++tfxyGJGDpKIOJ8gZfcgR0zcVVMYBoUUA1kFSVONTcW6gFCeveaHqWVII/dTTU
         hexjA6eF414ePESlgAYZmU6NyQ8JgEaGpanTuQIWjPatc9XaMyWOtVa4mm3z/teCA97m
         GatEe5tRuO2YgD2i6GFxHINJ7pAlNrdpacZs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794289453; x=1794894253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ljX0hqkFpVdDO4bWmsipvvF8GC2kb5FdkDBtLth2A8=;
        b=zf7hiiEl1rr8eInb1Ha7EGdOqKr193nLsMHIPooyB5jqdyEdtoWOPeBKcjJq/KxvrV
         vMMkm98NK76AkR45yRkjFXM6kSo13dKuIRGIkb3WF+6CGwcbiUEogO3yndV/DW1hL3h0
         WHtvg8ldW7Z7kG4aGnBpmBnDG6rD87uXyXA3Y2sReexIMxV6yiJ01QueWQoPEDw/rqe7
         8Alvd9N5TAO+ZOOYOI4VknOCGVlPErx78CG60Yio7yKbQSMIaTLIOGY2lfRWtE0ieN7Y
         1aySkfrmKrI7G+fRC7M+8pe3QGDqn0oqtIWJUuHGZGStgNgosD8Nwh0APpRd/MFUgIjt
         3l/Q==
X-Forwarded-Encrypted: i=1; AL+hErGmZGpbcWU48bbnQEI86F3A3e6Fc0AyrxmV/y2VMArq63wjI8PfXPm71BnPzzDgjCLlBaIiCXw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tB7MBBA0Al+v8gPk1EEzjWV04yqRQdnbmTtOARAbq3oqVx76s
	xcsLZGtJXiD6InsVf0nY9fOQ40ZDrHtTYp7/+kXuaI869mduaJmlpIbejmTn7d21i0o=
X-Gm-Gg: AYBFou1qyIftJ6cnxyaYedDY/JR6EewBcgxqg8WL+EYnW3DmH9H0FNqHf59doGDzkhw
	3aGoKi+Gsu0Njp8WmE6UChsAEd9PcUmLmkDh/A6gSpcf/oJD6hDt0BvZ3SgXl+D4RWX4wlSJkif
	8Gji1SSJK3BlfE6zJ9naqAhXXYBI0s5cxukpL4YTK/XGGl4T8/jxxcGf8jj9zoxrJS9IKHjkhmQ
	FFI0A37pHuvLnElXe9KepFkqVJy374Bcg4Y7SAZoAQ2Clkeu6H2HCGCSlUiYN1AfWcbh8H2+Wub
	hPap4+HPxTNlEvcFt5iGm+DXbmj8MpYJqZmg1PSkWNSFAIBriOpp0FYXVsHwmhVqobCwKLc/XGI
	zg5BtOcAx7LXRpViA+9d8bzE+4Ir3YpE1yn8KU00OLhBHW86egX/c5Frhg8+Z7wq70EmH45we7I
	j+Eud8fGbQEg2PHVmb5v7D/FFqAH2vdGT/D/UaaT20I3JwLJEAf2wYKyehQ43q9DEXMLBoELiWE
	kR4VmFHloAxmypeH96qV1E0UUcyc0W4GngsDQpzUdjqt7If07MAqWyJyWAyAvKL6kh1CRjVC//h
	+EX0mDDO+d9yPd+oJ3yIS1s7AgIxG8eQ+wyS6W24S+EafBYFJ9zAJg8m/7XbM1zn0VHMb9X4ChD
	e2j4Yf0IRhsQy85uMWYle5SUF6Oasug==
X-Received: by 2002:a05:6808:3209:b0:4a4:744:a4ff with SMTP id 5614622812f47-5683c99ce5bmr1527259b6e.4.1794289453346;
        Mon, 09 Nov 2026 21:44:13 -0800 (PST)
Received: from com-75606.corp.openai.org ([199.47.143.1])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905735edasm1258958b6e.7.2026.11.09.21.44.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 21:44:13 -0800 (PST)
From: Kyle Zeng <kylebot@openai.com>
To: linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: Validate user addresses in faultable buffer copies
Date: Mon,  9 Nov 2026 21:44:11 -0800
Message-ID: <20261110054411.75788-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

trace_user_fault_read() uses __copy_from_user() when no custom copy
function is supplied. That primitive assumes the source address has
already been validated, but the helper only checks the destination
buffer size. A caller that passes an unchecked kernel address can
therefore cause mapped kernel memory to be copied into the tracing
buffer. The original syscall-array tracing implementation exposed this
path to syscall arguments before the syscall validated them.

Use copy_from_user() for the default copy as documented. Non-user
addresses then fail the copy and follow the existing NULL-return path.
Successful user copies, buffer bounds, and preemption and migration
retry rules are unchanged.

Fixes: 64cf7d058a005 ("tracing: Have trace_marker use per-cpu data to read user space")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
v1: https://lore.kernel.org/r/20261006225221.54513-1-kylebot@openai.com
v2:
- Drop the trace_syscalls.c change, already fixed by 097fd0050089d.
- Keep only the trace.c change requested by Steven Rostedt.
- Point Fixes at the commit that introduced the shared helper's copy.

 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4ccdefb5c3ef..e1127768c074 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6289,7 +6289,7 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 		if (copy_func) {
 			ret = copy_func(buffer, ptr, size, data);
 		} else {
-			ret = __copy_from_user(buffer, ptr, size);
+			ret = copy_from_user(buffer, ptr, size);
 		}
 
 		preempt_disable_notrace();

base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
-- 
2.55.0.openai.911.g06873a30d2f3

