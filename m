Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEB850EC1E
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796262; cv=none; b=KtwFRtQ6DeQBhac9B0qK+5spz46y+VELRQJ2Bfvy97J33HmZvVGXA6nxWyMAVfWSKr0jdmT+Uditvr612EF4Wm+llE9ovSr6uqwgCBG4qaRBPAfsYiIU97oOEsCicKGOSduDO67MCY/gnyWXlAUTKhWheSnEz8UNddABWJ2WVNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796262; c=relaxed/simple;
	bh=DhiBgG7xnL08u0x0FTkYm6cczKwYmCOp1xitilaqnUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/F71Fr7JabkHW1euqfRHrxaHUGeZmp0TYKUqnaPywhOUynWs/vmnhIhLpuVRGfSHNmHHfrFLxQpYB07GEG6AbHhrRfRFIKNYlBRioYAJW9XbneTeoWc93/AEPujS6VexqoPyYIO2Xfghi6WZw8jeRR6ngm+GjE8odiSXtjWxXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLl16i1H; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLl16i1H"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cace91f112so29857435ad.0
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788796258; x=1789401058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CEKj5eE4ZkqVaXrVpceSXQRZCzNc8P/mNmuBsDFjR7I=;
        b=LLl16i1H7jds4lCauJc5qlUPdeYVj/+PycqL1V7Rwdnvn5owCzXfjyPGniQh+vazkR
         +3GTsKQJjNKPbfNBSrzLjlhOeSOaJVd17g7+ekmP5LMMQGNpHy0dKyBSQ0+bYCDzF6fJ
         MEQwrYAACFGs6QYHfeVS/qFYSOs5SnFC2fTSbHOcmT+1Hao8/VWdNwIPLovLrhtSvEln
         NTclDu0wf27AQ+5Hs95/BPPZZzAWbHLn1B6frDGEhsbT0g1mLo0ZV9TlVsXPSdQV0c56
         i0n9U40O+y9yJNUCUol3kZBp0g5wl4rwk+ypT85pHRxnYapuDumLcqeCVaqlYIXk1D/v
         tSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796258; x=1789401058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CEKj5eE4ZkqVaXrVpceSXQRZCzNc8P/mNmuBsDFjR7I=;
        b=mtMdb+pxGKGhLctxJQAO1rbDTVFikpiKZgw370vFyklrsCOPImYbBREpbJe9UeQNGn
         LgpUrcvFDz1If2pY9FdxLn1tuyICxzX/Mr1l0WXovtpX/Rb/4j9AvZ65Tmj8KExjq80a
         ZPtER1A+A0VFnBkZmie8IUTTmHFpl2Lif9rb5trAwH14oFPRh6j7u16oncM1SBi0DX/R
         ktmIJqQGh117bay1m/A9bBujTrK4E/GVJn7jaNHcP+VxXobcKjV+sM+YfPctLr1yD9Hn
         /Ro8pKWCnhKKirMiAc10X7ns7HgbYrQiSnR1Gh5uXTOGl3IDap4D44v9fLvJKenTnmCz
         pMOw==
X-Forwarded-Encrypted: i=1; AKwUvBxs8uz6k/b/RTyhwyLTqM6DK29o+2MU6LClna/V3j0hw07rjN9w1iHsZW+36f4dt94sq8tfNcQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k0jHIeVmM8Wuw79gVr3VmW3yAjjIcf8WYFjowrA+fZ50U6ZzpF
	Ybf+Gif+elwgfhTodVNEptfEL8hICQuEzsglqhdAb6ayUiMC7NPrxfI=
X-Gm-Gg: AYBFou3+w7ylh6PbQ9RjifkUW/ZRwyfhUaqlY0gvSTm8FX0yBB+Vst5c6s/+Luk6K6j
	jAxQe+/p65T3lIgybwDQXVvAy46m1bDfMf2Uba+iYml0y547ITmpqKkGTWZDn6dNUAc5KOMBgwL
	e+3GzbLUe9gORHlqNTUo3UJcvBBmp4LGpYkUuecWEe4MWSVuDPQeFPY9XoADLHZ3te/4LL/YzPd
	Bh1+BnTlME5pfH8KMr3GD3i+hGdodqyZol9N7r+r2U22ER9IUyZgtbmGsFbkLUypmtFbWKSH8Qf
	8XQ+YLIP+yd1bwiboprl0ypQZ/kLv3lLPAn7lRUy9f+stJ32WpNgn2nmtaCUZsXCtd96tNsPZ99
	ZyuYrcuSMAFVAdN86WJQ3QG6MCHtX1N/qnr+akHJsO86+53zuNImcnbk4YdgunUX7aeREaDkszx
	c4zNTWjWbVDvAfV1u/yzZAnwZByOpLxcdJ36B6vRJ1JrcCqnD3V6pXwjrlZLDExIQESqnpd2kID
	40HnuClH0HQ0OK6
X-Received: by 2002:a17:903:3c24:b0:2db:479a:5127 with SMTP id d9443c01a7336-2db479a55c8mr128165285ad.19.1788796258200;
        Mon, 07 Sep 2026 08:50:58 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:c773:5f09:906c:a72b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db149c3b80sm47265405ad.63.2026.09.07.08.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:50:57 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 2/2] tracing: Fix memory corruption from a "STACKTRACE" histogram key
Date: Tue,  8 Sep 2026 00:50:45 +0900
Message-ID: <20260907155045.692664-3-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907155045.692664-1-donggeunyoo.kernel@gmail.com>
References: <20260907155045.692664-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"cpu", "CPU", "stacktrace" and "STACKTRACE" are generic fields, defined
with an offset and a size of zero so that the filter code can match them
by name. parse_field() maps them onto their common_* equivalents for
backward compatibility, but unlike the common_* names it hands the
placeholder back to the caller instead of NULL.

create_hist_field() takes a non-NULL field as a promise that the record
carries a stacktrace and picks HIST_FIELD_FN_STACK, so the __data_loc
word is read from offset 0, that is from common_type, and its low 16
bits are followed as an offset into the record. What is found there
becomes the length of an unbounded memcpy. Pick an event whose id is
small enough that the offset stays inside its own record and the length
is a kernel text address:

  # cd /sys/kernel/tracing
  # echo 'hist:keys=STACKTRACE' > events/ftrace/print/trigger
  # echo hello > trace_marker

  Oops: general protection fault, probably for non-canonical address
  RIP: 0010:rb_next+0x23/0x60
   </IRQ>
  RIP: 0010:memcpy+0xc/0x30
   event_hist_trigger+0x2e7/0x12c0
  Kernel panic - not syncing: Fatal exception in interrupt

Leave the field NULL, which is what the comment above the branch says
the code does and what common_stacktrace already does. FILTER_CPU and
FILTER_COMM are left alone, their create_hist_field() branches never
look at the field.

Fixes: 4b512860bdbd ("tracing: Rename stacktrace field to common_stacktrace")
Cc: stable@vger.kernel.org
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
'hist:keys=STACKTRACE' now reads back as 'hist:keys=common_stacktrace'
rather than 'hist:keys=STACKTRACE.stacktrace', since hist_field->field
is what the print side keys off.

 kernel/trace/trace_events_hist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 620a74fc62e4..eabe95419b97 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2417,6 +2417,7 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 				*flags |= HIST_FIELD_FL_CPU;
 			} else if (field && field->filter_type == FILTER_STACKTRACE) {
 				*flags |= HIST_FIELD_FL_STACKTRACE;
+				field = NULL;
 			} else if (field && field->filter_type == FILTER_COMM) {
 				*flags |= HIST_FIELD_FL_COMM | HIST_FIELD_FL_STRING;
 			} else {
-- 
2.53.0

