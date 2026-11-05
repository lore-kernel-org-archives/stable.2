Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877179;
	b=BguUkvE/zuNhkkkIn6uHL1Wq2nhzdx6hrks/8050BfkATPyoUtJzFggONTpAgopYrdfa
	 KSh4paF4he6y8Bvh0X/QDrgo/jh9CSxdu0dWoJc/1DbDCEth+ArmOcVOKPcgee9WYyZ8R
	 oibFM3qQy5Wpi3aDHWKXphKXbEXYBbc7FyiOR8J8KkJoAJAdDYrLYp0kv8LNLfO4E4fKy
	 7DpjfF/VFVIWCOMcXXLQdvCflyHzLiFXRK9bO1ojVw5uW+slO8p/xHQk7VYHCyAx/J/MQ
	 SizKxMDx/FlF9rUJNI4j6+0DC+yNYgxIzn+eCQm4ypd6oyDtSnICuw1ARDeXrn5daew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877179;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=6vjyiGIRoP6f/zO9hxEixZrq8kzu9uZMm6qA66eptAg=;
	b=zuXh7veWl1wh9Mhrs348s13gwuXayHxYEPqjPSumO2SQIFNE4/xskcXGYN6lH5PfJxhQ
	 +an6szQubQFGjOSA/N03RfnaKW/8UK2ScTwEgW4swHgRP8skNxsICBhLYZSeFFUW8HOe8
	 O+DEesoAb6MdV+Lp6AfLnQJU3koHnFbw5GuHGlRZOiFDRYe5UK3eAJHeC6NDekNEnO6jJ
	 zuO+i4yhbg7ZrszCPj8BevK0P2eMyV/YWnqQNoBpxyqKDydjfjkhKOG6uYOHI57KtK8+i
	 GDn8vOl5I48yTkwdAu96z3+dlS4AE6VRCbRXbE2B5NzbvdyO8/kb2ruXPtbcc9SqznQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=vjRST9MO;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD09F606A328;
	Thu,  5 Nov 2026 11:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD09F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=vjRST9MO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=6vjyiGIRoP6f/zO9hxEixZrq8kzu9uZMm6qA66eptAg=; b=vjRST9MOrlSiEWOiB/CtbC0Sc/
	K/8EuJFSfxZs6xtaHWs/GJlfmv20pA7Ag6k+ul1JS5973LQEYXofJTnYtdtqeMfBUiew3b9I4UXzk
	F8eQil00FQU8Rsg95sAnSuf3KzJXhqcDOW9WosL6dpBe7QwykR7eJECXhah5pfdPx7a52Xc7YuHBD
	In5+BxW3SWkaWtkm8VaYpfIqsXOaDv/jy/MUdIAN+SxNiFmLbBf9YYr9/qJLLyEZEXL9V0ZtyJso8
	9Ci1KpuaRUeI9UlHxiEcpXIWU9YlUrv37Bp4SKwlT1LIcoAOoalHhQPDsRGqMnYk9kbdhQvZ5GwQv
	nOyWRolA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOvOi-008SOs-1X;
	Thu, 05 Nov 2026 11:12:49 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 05 Nov 2026 03:12:42 -0800
Subject: [PATCH v2] ring-buffer: Handle a reader taking the new head in
 rb_handle_head_page()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-ring-buffer-head-moved-v2-1-05da40cebccc@debian.org>
X-B4-Tracking: v=1; b=H4sIAKlk7GoC/4WNQQ6DIBREr2JYl0Yoauiq92hcgHz0Nyk0HyVtj
 Hcv2gM0s3rJzLyVJSCExK7VyggyJoyhgDxVbJhMGIGjK8xkLVshaskJw8jt4j0Qn8A4/owZHPd
 6ML5xRiulWBm/CDy+j+N7/+O02AcM8/62NyZMc6TPYc5i7/2VZMFL2kZ3l07XFtTNgUUTzpFG1
 m/b9gWHOcTvzwAAAA==
X-Change-ID: 20261102-ring-buffer-head-moved-f9caf5da9444
To: Steven Rostedt <rostedt@goodmis.org>, 
 Vincent Donnefort <vdonnefort@google.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Steven Rostedt <srostedt@redhat.com>, kernel-team@meta.com, 
 stable@vger.kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3440; i=leitao@debian.org;
 h=from:subject:message-id; bh=CJmlLfCQU+JeiPNpiR+gSThux8Q0K3xWUmTQdi3OLi8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq7GStplCZ9lWp2lJaCVcItVooZnYKcgn9Y4hNj
 lp7XJ4MKEKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCauxkrQAKCRA1o5Of/Hh3
 bb6zEACvFPFsZMGjfPubQhe6PSzlJ/wMshG3uRAjRWYaE10CIhstCACQc9tlenOGppOrg/beyD0
 m+6VTDr77efUmfTKxx1kq3C44sl+V4FZaEfjW8EwLT6k1CfVcNRi8nrSWRFXKWFonTaYkFC8/fe
 BbihCpZh1wXj+Z+KJ9uPY4bYn1+KnzmdGTyMN+WbX53uwk+J7Q8v34KaaoFMMLypw4jazdXKTmy
 qV+QwHjLA2/zEeRoqlmkeDBp8xdN4VJwHcQKZMuAL8KcO2ZCpmySt0YCqtKq6iHln7JhtVB4+uw
 NeoPBVm696fLf3n8GkPCav4kzMHY+OqhoiBGvDwuJ4Udoe0tg/ngX5C9o4JjpuKz7L6tOcckDgi
 z1Es21hPDe+LbEuv+aPSlH2upupqrfkvw36pAKSRJL/CRhti40h3Qb7Kt8hHazFv9eS9FWAL/ug
 6CoN4Ua/ZHCTU5SOK/SQzeXtG6xV2zv9FDkWE4EltNNsCvCDN8IjYGRNgnoy+PDwBAVpPiqnX/2
 0dHSLSC4SVXtErMYLVdiorbQBiDXuOfc+PrEw6ElWjwy6b1XQdIPfRgXvubOlSkrEzsOrHme8fG
 22nxZoSCVEM/QPmbZ2pboXNN9UeI3TYByEeAgcLjj5WVMYUa8afNdkeBlnoElIBP8xoamzzV1KK
 28M8Uj/s7sO9xGw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

The following warning occasionally fires on a KASAN-enabled debug
kernel in Meta's fleet:

  WARNING: kernel/trace/ring_buffer.c:3793 at rb_move_tail+0xf78/0x1050
  Call trace:
   rb_move_tail+0xf78/0x1050 (P)
   __rb_reserve_next+0x648/0xac0
   ring_buffer_lock_reserve+0xd00/0xf00
   trace_buffer_lock_reserve+0x28/0x188
   trace_graph_return+0x220/0x3e8
   ftrace_return_to_handler+0x2bc/0x5a8
   return_to_handler+0x20/0x48
   __arm64_sys_sched_yield+0x18/0x30 (F)

rb_handle_head_page() moves the head page forward in two steps: it marks
the pointer to the old head page UPDATE, then marks the pointer to the
page after it (new_head) HEAD. The second cmpxchg is assumed to return
only HEAD or NORMAL, but it can also return RB_PAGE_MOVED:

  CPU 0 (writer)                        CPU 1 (reader)
  ------------------------------------  --------------------------------
  rb_handle_head_page()
    old head ptr: HEAD -> UPDATE
    new_head = page after old head
    <interrupt: nested write>
      sees UPDATE, marks new_head
      HEAD and moves the tail page
    </interrupt>
                                        rb_get_reader_page()
                                          swaps new_head out for the
                                          reader page
    cmpxchg(new_head|NORMAL ->
            new_head|HEAD) -> MOVED
    RB_WARN_ON()

A nested writer that interrupts the outer one after the second cmpxchg
still sees the old head pointer UPDATE and repeats the second step. If
the reader swaps new_head out just before that cmpxchg, it returns
RB_PAGE_MOVED too.

RB_WARN_ON() permanently disables recording on the whole ring buffer,
and the outer writer returns without clearing its UPDATE flag.

In both cases another writer has already moved the head off the old
head page, as when the cmpxchg returns HEAD. Treat RB_PAGE_MOVED the
same way and fall through: the outer writer still clears its UPDATE
flag, and the caller updates the tail page as usual.

Fixes: 77ae365eca89 ("ring-buffer: make lockless")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Fall through on RB_PAGE_MOVED instead of returning 1, so a nested
  writer still moves the tail page (Vincent)
- Drop the duplicated UPDATE clear (Vincent)
- Document RB_PAGE_MOVED in the "Valid returns" comment (Vincent)
- Commit message improvements
- Link to v1: https://patch.msgid.link/20261102-ring-buffer-head-moved-v1-1-165973790be4@debian.org
---
 kernel/trace/ring_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1fd28a72e6ee13..44782b71664722 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3783,10 +3783,13 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 	 *            1) We really set it.
 	 *            2) A bunch of interrupts came in and moved
 	 *               the page forward again.
+	 *  MOVED  - another writer set it, then a reader on
+	 *           another CPU swapped it for its reader page.
 	 */
 	switch (ret) {
 	case RB_PAGE_HEAD:
 	case RB_PAGE_NORMAL:
+	case RB_PAGE_MOVED:
 		/* OK */
 		break;
 	default:

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-ring-buffer-head-moved-f9caf5da9444

Best regards,
--  
Breno Leitao <leitao@debian.org>

