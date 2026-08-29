Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A884231E83B
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 01:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787965472; cv=none; b=Pa+KbzUCohms+DL4aG6usCKQbF3536BtOf0I4ySZfk7rhcrnpIouIr55iClnCovY/RNNIzxTuD7H6cTWfDT0bx/HTKI99rTyTDJEuKYLfwslvqRoNU7XYiO1WTKCVs/2anAPmvym7WkruDBqBhoM2bNQyz44M8aXyJYHBtawDDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787965472; c=relaxed/simple;
	bh=8YWpV4BxrKzVyIl/iwj/YMPjck27je3e2lc5dcgDYFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sy+V6I9iTD7fW588LnyX0yjl5bpC/19heB3/5JDYEuq2pqll8UaRmrz74T8QVBUHEtFvHlp1Z+DfQWoMmA6OZqosYTkyCfQUNOVyewIulvuCFwl9Mt805WlpfEq8Mq1KHEJomEej65vYHksn3loXny/4jpUB81EfD1VRhIodH7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6I+F1f4; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6I+F1f4"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c96c92c0980so1094559a12.3
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 18:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787965470; x=1788570270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=whJWdgZLbjtRSnzZmPCdoj842hOmWmmPzuhg02zkVIw=;
        b=X6I+F1f4Y1yuquyP9TKTplvq14zi0U7Xcf/4iFkEw05pOLcGh64YQCKIKxBBmHVUA0
         pUjMhPGmlLkzqdr/aGrNT4OpvXCxK6RQLRmaiz/BOBPjdr9dEUUIVEN9ZAcU/rZ4UNep
         eroO57JaIaFo6l30iYkIg4iIvU+ti9J4kYIRHGUibMT898OzYHUeLfYs+NCb+08jXhzK
         M02joZsnhI9zfniE5mOQWfwdpogxo+rAGZ2pAlFA+gp9qIJGC4qRT5qgjho3v76xxDkQ
         pUk4ywZCB8IUE3k/RsV7pIS7G3NVOn+xJoeuheLyYpGa407Xk5jfEUYTzvyaERMY4sKl
         uxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787965470; x=1788570270;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=whJWdgZLbjtRSnzZmPCdoj842hOmWmmPzuhg02zkVIw=;
        b=ZmUc47huFoHgfWIjVOoB9o6d50caJkAvmcmaxs2f+QgzRzMP+xd0X6L+FFkOf9PRxq
         7GwhT6Gc2/5nfxjT5Yl3z1w+zjDwEruf2xmHpx2ACDG1lIL9QwJ8nMsdjBo33noak8KW
         xvLme8qhMEYAlBp5EBPnunPAqQNShCGwb/ImrXf+PiXeRbpIUuDe550ohVshQhNy9CZe
         i5UB1A/4ev8iw8BkMqOh0DJ7np0bqhXc59ZyQl6lAzq5ptocDkPsuDsWByonaerJ9LYX
         Rqxpv+IBPRULeAwe+uiJzxbMMpQJbC6bI9zPOXCRn8K+FJvb3cWaHkWRxnzwGyWYhmV+
         eupg==
X-Forwarded-Encrypted: i=1; AKwUvBxMz6pUbVrT0DiDaN6dpFAiFnLtKhQVFgLJbNhS5UGI96WcP09LEkRoPMPhWRfnsNgfSwXc3WE=@vger.kernel.org
X-Gm-Message-State: AFuF++lPR1hWgzXvAz4dmPo8EuzK5CQeGFBF2ETsx9Ui2GHsZzAcq0ZZ
	c34Tb5WZH/jXUlmSrN8DKHgk9ud3ST176zA8hWXcx7yYG7eGjlh7LSdz
X-Gm-Gg: AYBFou07FIWs4uPCM+64fuZOymtIbUZjytTBQ1RAlhbXc//j32w3RoL3+gAw4wOo552
	oGCCs9uO6aeXEsJm5ubVJSLWJYx2aSy8TtzABu4wNWUwcLsG/9XXPQ2FkFVxG2TTT3z9yMnhRqy
	ZtrcWjxrsn6pfi3KtQLrLNGsNLQzfjhdAQS9MCqoduc4EGO3x+GKXDuxNMyYGfmr/R9LbALxHT1
	EkWvSwmxFDli491E9ssC+EXbczIULiBxCTqavYEypJE2b2W5R/WQ0fn9UA5XWEe7hyujjhhDtT+
	CCWxvQ3rk/vHwr5RYMDHc6lXgRJoCOog6hIdXrbmxUwTAY36OOGgF7ciLBqppodmm7vcgD4dMpw
	b2o04PjgD+nFahgc8leHAY9BcovGoGNm+4MEdWcpKI0Mz6N22kbMdDZqdHCQBTu7UkFzl2LY75s
	JQ4szEqINkat3CEzuJDZNFboaNzpzVDo/+NrOJSyslr/LgSwvxpuP3lBZs6SIlvCIG0NgqXyP8V
	ZWyf7103SLiz5U/nDeS+DNeaopFpWKHNZLDeVC/6yDgSUC/9EB+vM7qtyQtSVvk0HBFpwXg6uWw
	Ooy0yAzFKSgxcZtFTbBKB3gE
X-Received: by 2002:a17:90b:3ec7:b0:38e:250b:122f with SMTP id 98e67ed59e1d1-396d1041324mr16954197a91.16.1787965469892;
        Fri, 28 Aug 2026 18:04:29 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b186803asm9247989a91.11.2026.08.28.18.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 18:04:29 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Jason Gerecke <killertofu@gmail.com>
Cc: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()
Date: Sat, 29 Aug 2026 09:04:09 +0800
Message-ID: <20260829010411.7874-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANRwn3TWTHxP=ZEpgZzjRweC8vqifoi2koKgSQTEuPuY4FZxcQ@mail.gmail.com>
References: <20260825103104.12090-1-98lawweijie@gmail.com> <CANRwn3TWTHxP=ZEpgZzjRweC8vqifoi2koKgSQTEuPuY4FZxcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Aug 27, 2026 at 12:02 PM Jason Gerecke <killertofu@gmail.com> wrote:
> I would appreciate an update to this patch with less confusing wording.

Reworded in v3:
https://lore.kernel.org/all/20260828033323.82958-1-98lawweijie@gmail.com/

> I don't believe there is any situation where maxusage could be less
> than report_count since it is initialized as max(usage_index,
> report_count).

You are right. Thanks for the correction.

> We would also *want* to read fields beyond the last-declared usage

Agreed; the submitted v3 keeps that, and the changelog 
notes the 6.2.2.8 reuse rule.

> Given the above, I propose simply making the loop condition " j <
> field->report_count". Thoughts?

That is v3, with Suggested-by: you.  Retested on v6.12.105 with a
kprobe on hid_field_extract(): with your condition the 12288-usage /
Report Count 1 descriptor extracts nothing in the driver loop (the one
remaining call is the core's own in-bounds fetch) and trips no KASAN;
stock extracts at bit offset 98296 and does.

As a side note, I am also looking into a separate but related read in 
the same function based on Sashiko's review. I do not want to hold 
up this patch over it or speculate before I have it pinned down. 
If it turns out to be a real bug I will send it as its own patch.

Also my bad, I realised I had not replied to this thread addressing 
some things you have said, after submitting the v3 patch.

Wei Jie
