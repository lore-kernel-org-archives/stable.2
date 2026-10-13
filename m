Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6607552F29D
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931061; cv=none; b=qaW17RVr62XH46erBCnMYq4DV0WLQGjGVuo09WHeV3V5tzzdk1yK1IB0zdwLPQ6xMnQ2k3ytDNDmOuPteB5pvWYyPNJ3V0ha8ai2/ZDhp/eqr9pnAC0MU6NTlPPKN4l0LCk9CPtb8CjCsikDeJgKhqsu3/mDXW42cWJ6IrHM6bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931061; c=relaxed/simple;
	bh=4XvU5aUK/OdhJN2WdfPwhyvpjo9S7NxkqaEpAtbL/qY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hroVER/JwLgCxkZKnFKZhySF+rFViRadY5MRc8/SEjrqSXz7wcN77lX0ZFUH3MuMJUNuc936b6WiNc97/OOTjo4+lpMLXwdZF2RZDHH0ey2n9l/H3hXnuiawajq/BMvR2NYYqcIdI01QphelDSocpv5CBTkOSrEXpi1MYKoG/Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=L/cPnyQK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xcX60cI8; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="L/cPnyQK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xcX60cI8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 97D48140017D
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:37:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 13 Oct 2026 18:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1791931058; x=1792017458; bh=oJ
	fB7fbIofmtvN3C6uday0xkoE0Q8pgtxwAHK6ogrPg=; b=L/cPnyQKij92t/R5Gl
	DssEPf1EdvqmAddBMQna2vROuDg+Nkqp+hXcuriJRiimY14H2eVqONVpif5EVJCp
	/XG5z0/2SHvHDVROuXixg3AGMPuGbgEqEmg4NPkXuJwPE0aBrQUaNoZkgd5f42uC
	6PC1/fjgG2PVSMGuuuNb/bfndniTr8RqvYkMSNNBxiydQ1qoY+KWyyrkpyNSuIsE
	z+a/gItXebPUzqAEuLwHzEN1ckXEDiy3x2Okn1QqdGeLdrk1s7cykbb4cKxP7ABz
	G9l02gX5htiGNRD5HQZ0FjHGrvPaI0QGseMSMVZuCs5/LCL2vjjPER3RvGLWFYvM
	zcbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1791931058; x=1792017458; bh=oJfB7fbIofmtvN3C6uday0xkoE0Q
	8pgtxwAHK6ogrPg=; b=xcX60cI8jX50aYQXKXR2sA4n5eP7Eh9w+0QHrmulj6B3
	63aipDfl3nyoZzbPWS48gXEjTlMxXKLDd7z11kOcRbst5WbFcWluziD4CeHr7ok5
	z7Ek4uRnB33HwiSu33CGj0/5iiokFzNu6fRCFQy/tviNsyVUhS1VUJYzyaEXhfCb
	7znZWNncqbydIy0Mif1HFHrfFYdKqg+Ffs7qiwD1qeYA/m6RsLq2KC4hmtmV6bmC
	8/FTyWHAl68KEt25hl/jVU6gc6d+liJ1xRnEdmVr23Cp1Lmb1NABMYpai+qHb/lG
	XfspK+3z0HNYSHHVLkIVNcw3i+uHj62Yg9JKmPlB0g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791931058; d=fastmail.com;
	mf=PGp1YW5sdUBmYXN0bWFpbC5jb20+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lBrCrbXVlBxXs0pYIJTxxwB+Ng2u138orkW7IAAqZQCo78f
	pUim6Vm06573C92fYpc5vCiB7AUoBtDEMumUvbQEBH9cztoeoZYDeXzXrEiNhoZt
	IHd+seLPwiW/VsvtYOF9TNeGeRjEguD9OnkxO/GtSUTNWOt+XSJ8FJsdV/NS41zG
	Y5fjjN0H6liyQ5kDVdz2J/moLofhU0qRLTRI+h4qEXl3MV2CdW1/OBlBBsyNvSnR
	1SrPBM8BWvtIIg0Fou82aBfQxR4C1VBe4k1VF4WDJQdErClClLmjGu/JlgvvPZap
	zNja5FMwcewRfZn93AyJp5miIrXz3W2GLlc+OnA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:IhEcLzFycOdfR2PMruEX6zJuXAqEdvj3z1u6C3VbPPg=:4XvU5aUK/OdhJN2WdfPwhyvpjo9S7NxkqaEpAtbL/qY=;
X-ME-Sender: <xms:srLOap48rx259eoMNGBrNgp9l2YrWDgWpwGh1-yOUk_aP7-bhEnzYQ>
    <xme:srLOaobtW391vQar8HTe2ExS3gTVjdAbm77a8TySRiGyGIN96Ii4Q6NLo2_KjBXz-
    pxMZ5mjqJcOEuZy-MfRh0EjQ3dgWCgzkxAflUST7EnoTmV-9R1rKGwe>
X-ME-Received: <xmr:srLOaghDKDIeLKcN3PWDrg3N7cJLg9KVTulX1XdoYOcHj5eQw-y4zZ-Nb8gbyP2n3IFpzmfcagJPL8JVgIg>
X-ME-Proxy-Cause: dmFkZTFDSwAOX/nmGgfCWNy8XIQ8gdeNCmGW2diXrSJHDLXEG/zVFtX6KeMKLe+yU8RsCZ
    SSF/Xx7Jzsd5AsR1A+G1b6KCcUeqp+6ern+2RxiDRmgK7aX87neUBcQ/9tQxGJo3MjRrM6
    gNiilKrOoB6xAVN6wHev4bHGJNva/r701qoiDveKc+OmX6fTZPei2DA6TFCqVJk5pSGfoB
    eQax4BR7VkcDujz8e/UWwPa7uP1U551ukEIo2pA+0jYjR1UfwOLhla1iQhigNpyCfLAWhV
    yFmjismpY4IpXxU486lxvGiOECmNUZgBdfJrEIOrLLOKRSD0PZXMbFSIk+mVRbM6HI7UFE
    iLQG5vW5h5383l8Ledj7szZA7KTHw7wEPqS7cAqo760nuHbsHgCvmxIhdhS0oTGdpvx13D
    ZM7wLbKRLybf+IDY3cliNcFmjQXaWwDu+4W22MV2VrTFB71kvXtoZ0zC1QEnBbPOJWoihL
    nsDA6fC5FRP8Cu6ISJlpfpxYehovhAQlFshEOoaIRXc8T94ZK4si4lCg4uPEEQRVpHR6Pu
    kPZs9doHRGovMfo7lmhwO+CmET4EouSUxnX9RIP85KldUojbzG4aopuommL0GE/NyN1Qba
    m7OC5msKymx9A6vz8hLj/PjxTTk6Q2PlqBR7mfpIeR2JdRbklJ3wehevbu1w
X-ME-Proxy: <xmx:srLOah8UukaBl0tQfoNjX8Me59aeW_cfy5ZTcAOmYKSHGKt2CLZevg>
    <xmx:srLOajqzGxDwqGnaizULCY7eiHC1E2Z_EtBffYvzI5xr5UPbN9Q0jA>
    <xmx:srLOahWtujtev0qaRfJGJGRVibqBd7r52iPBHFCVkXOKyXoR9x40DA>
    <xmx:srLOaqDqGzQBmC7vm1YJ31eDORQlMwAFZezA7wTqNxSLo_xzkZYYsw>
    <xmx:srLOan-NXTJkVPc6V5sScy31-wShJxpX2aI-KAiVAuuDd32Di_kHunvU>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 18:37:38 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
Date: Tue, 13 Oct 2026 15:37:20 -0700
Subject: [PATCH] io_uring/poll: avoid retry wakeup loss when dropping
 ownership
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-pu-cmpxchg-v1-1-4ddc10fd8a03@fastmail.com>
X-B4-Tracking: v=1; b=H4sIAJ+yzmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0Nj3YJS3eTcgorkjHRdy0RzgySLFNPkFMs0JaCGgqLUtMwKsGHRsbW
 1AHDzBdlcAAAA
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc: stable@vger.kernel.org, Juanlu Herrero <juanlu@fastmail.com>, 
 Anand Natarajan <anand@meta.com>
X-Mailer: b4 0.13.0

If a wakeup sets IO_POLL_RETRY_FLAG between the owning task consuming
the existing instance of IO_POLL_RETRY_FLAG and the loop check
of io_poll_check_events(), then we stall on processing the request
until an unrelated wakeup comes along.

Using atomic_cmpxchg instead of atomic_sub_return to guarantee both the
count v and poll_refs are 0 and no wake-ups are missed.

Cc: stable@vger.kernel.org
Fixes: a26a35e9019f ("io_uring: make poll refs more robust")
Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
Assisted-by: LLM
Suggested-by: Anand Natarajan <anand@meta.com>
---
Validated that the stalls disappeared after applying the fix to a small
zcrx testing script + bpftrace using nodev on 7.1 with a VM dropping
from ~50 stalls to 0. 

https://gist.github.com/jlhe97/cf5affffe75e709ba1627e5e0e6405a1/

Similarly, A/B tested on hw using 2 machines containing bnxt NICs 
for zcrx and set the needed ethtool flags/rules. Over 10 minute runs the
patch dropped from 127 stalls to 0.
---
 io_uring/poll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/io_uring/poll.c b/io_uring/poll.c
index 5447a7c24dce6..44765eafa00dc 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -330,7 +330,8 @@ static int io_poll_check_events(struct io_kiocb *req, io_tw_token_t tw)
 		 * Release all references, retry if someone tried to restart
 		 * task_work while we were executing it.
 		 */
-	} while (atomic_sub_return(v, &req->poll_refs) & IO_POLL_REF_MASK);
+		v &= IO_POLL_REF_MASK;
+	} while (atomic_cmpxchg(&req->poll_refs, v, 0) != v);
 
 	io_napi_add(req);
 	return IOU_POLL_NO_ACTION;

---
base-commit: e889b0e4cafddb3d68c3595dc01b7128fd35fbef
change-id: 20261013-pu-cmpxchg-9a70b8d5cd9f

Best regards,
-- 
Juanlu Herrero

