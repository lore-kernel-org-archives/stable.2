Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794092642;
	b=jb3wuY0HLZ6m+UDtnMF3Ne1q94OSgvANry7cwTvWxAuQ8rxZ3vDwCm1ljSfUm0Kq+3I6
	 H/Y/nGapqgYo9A/roRqgdU8LD5eSpQcn4IWGnXMk8Uw2AIvfK928SJ2jsjoIzwscIMrGl
	 CCJl0LeMEJeEk8w1sC+7eAAkQJ/yaXchvgmZlPlHv2P/taZwEW0Z9Fnf1gQxdjuf7uqcu
	 Se5zv4p4ddtWbqHPWDON5lpFFe/lMzi2+94GFO2EzeUx1pEqkYQlJ8ZciAdutHmKiHpXL
	 Pi9CLYr275D/HXrQRzzry2pZG3nde2zY5jT8y/SyTmBwGsIWhr3u0QfvMtnOzZ1F2wg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794092642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=/Kn9Zs4oMRbJfwh1Mlpr/6MFK+LLCC6W07GeAkXkBnw=;
	b=QattEKOevsjTTNxn3RkfpH7G7beW3VcfIhaUolTbpJl4STcStD7lqwKu15uGdu9I+9DN
	 YZfo1KOH05w5Hhvb0eVDq3ea5/vml/8l9jo4OUNEiNRg8bjBWOAcFeYjrNcLaDDmF6xgx
	 YMoCFHT6bAEkG4eaBBT+PU/xOo9on+oWvNURwei/D3D/FpeQ+UJMSFeB72H7Gq35IlBof
	 Y53H4Z1qM3HLhFiPNxPSc5PVFo01leKjIDses7IqWi8DrN0DTkjbqLi4z2zfwBBZHUUgT
	 bXoxJvr1SjJnJr7h6R7DPTD0NGtgpBA2TgkYYA2JPHgzERk6FbBrRPe6MPqXBrwhRpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EjHOcQyd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9F2606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C9F2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EjHOcQyd
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so47648a12.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 15:04:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794092640; cv=none;
        d=google.com; s=arc-20260327;
        b=VnotrGbr4V3QadgMTqeDfDicFS26ZuT2nNON80aJS3Ph5h2GuL+qYfbDo+zPqAtZNy
         RlmaV0bRSrGcBqO2W0j3L/Lijomy7YKWJguLBVEd6nRa2GHc0im0r51TYjwha53p902J
         Xri/s+eS37yqNO46cULntCaBdfd4ANgW+mFv8vCkpPBFUgVMRcAaDFuzYiQOSRzGs1Vz
         +96iShzxpyqlYdADpEIt4SujrbrIN6tN/YfYplWpSZQ7pO2/LpxcGNcWLLgTVdAJQm7X
         4ePUV2XpC4fPZ7/0BpvT5ivdObln7i8z3riHOR6JXRfpgQR4DCyqGrGluQS0ZMACdazl
         SLDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=/Kn9Zs4oMRbJfwh1Mlpr/6MFK+LLCC6W07GeAkXkBnw=;
        fh=+D7joyLHOkDufJb0QijkIT0qFXrlZL+5ONDeo4y1gns=;
        b=gN+BkKTw7qBbEmvkzqJ+ur8JCx2+McR542WiCcusqIeTprM+NJ8sBXuaDZXhnRo/nN
         Bb9p1bh9w6k1WRoZHdtfjXwFhKdF8F2h7QYFxiQctgA4omwEK4IMvM0zq03lqDxHEptR
         VsOlOOV6POWRamyZtFp2qm1GxaPEkmA1R8rL9SFd37lBNVSRt8yGbye83laGLDxQqvuf
         5fHyS2PQ4Ter9Oz0lmNHttIwYffvc7p085O0q1SUUkS1lVHfAUDoVSWmljU+YT2Ce/Uw
         oJPysjWdo5K11WrJEXityvS9EZ/49Ff1+bnSeArZHFFIRxV0BwT+8fu7WEEsMvp9woo6
         4lfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794092640; x=1794697440; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Kn9Zs4oMRbJfwh1Mlpr/6MFK+LLCC6W07GeAkXkBnw=;
        b=EjHOcQydLNQuejFupb2LVuxxR/Vr2BlAjqYFl2F7PHe0s5Hda+yKXJTh9K/LYoLPUx
         Joga6EcfBgZDGrumv0kpI31AhTQPUxtioTrQzXPELuf9qz+R8fAiinWDmQgzmXcWRzAr
         ERmVSWeVAr+kLlxy6PpMRig4E4icfImtA8sjvF+vsSenRf84GE2j+EtkdK48NEzb665U
         fLEIOzyClrH/1Tg+JrIhQpvmmlWaJTqCFXutzHjok+z/QkWmWlmXAmpfWY6jskU9nVRH
         wu++JisN5TUs3JFdWA23kZf36OTXNcG/EkftIol9o61pjWdFo4Vm4YxT09X5MbCPELhY
         60nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794092640; x=1794697440;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/Kn9Zs4oMRbJfwh1Mlpr/6MFK+LLCC6W07GeAkXkBnw=;
        b=YxnLrVQFB1zzpDv1Pb2SaBH2FyW0W6Kp9s37bB5KxCo9SOQRBlg5zfDsta5wbtgxca
         Y4JojUMgaeNnoLjGSXp1/nYoHE3zgbx+UqMo5bjZ7vANU0KVXniR8qsZQNsMlQRRzxzc
         YGYVV+Fr4+1d7FAZOljB1bmTO7h0Oo4QYE9RrXu8Zy5oD1lWR3pOEb0TUJmLVrLGLiTd
         KmXDvzgLmNhvFRr1wDJFRGP1D3J+mNVQg0mEY2dBgJexsYidgyx1m1hCHDxSGolDteE/
         PNCOGpUkrF1FE0L9pZV3M3kNaLdiMLe4jB/+ayuXXA9pOvMvs/UB2QAFluzvmhOJJyI2
         bK8Q==
X-Gm-Message-State: APuU4Z9Mf9eYcIDaDokyJMLopdy/bhlMqiRa/DkOpoP1a0gDmbX7onG8
	Olqk4lPgEhUzqo2kdRAMxBFxQ9PfU5uFEfpkwEW2ICWSopbNQqGBOCh+DK+Ud0a70uRiHAYdzx6
	T1gv2FcaZP5M5pd7il9a6SN+Cg/vkIWBydfASsSkCug==
X-Gm-Gg: AYBFou0GchBLki0LBnbjv61U9EQ+8pDe+oubZBApCPaRMijDAREnQpKeKMKO7FpuGeU
	bt9yliwIb2MhszyxTb20OxFPhLTIVsXx5IyYAQhIkvoMlq4FvQ4obfQPM/41RpfPm2pOhPlaR4i
	q3pahPUSEQImUVgqmeb1cLWSW889+IvhhHrOW/2krsUsnys2/XXLe/2x71L1+2gJIwbuCZ1VGDP
	t5ACEY4OETKpbL501UEnrXUmI9Ym3OSHACHOCxnqXqTatXdGe01biC95ABmygnh+M6zqp5kX/Wy
	vMHd4WQGnJo0PNPJSHbo1y2OSy5t0VSFKjoPddgk/dZeXFze32Jwp4LYqUndHDAU3VtdHaWpMIz
	nCEbQDHW4S5BPLGmvthkYJBCEV0CJjtUPmG7y6v0zkFnb3IPA9EDdN1KgsGpftz/EbT/pTiVN/r
	Osiy/+/I14uZcoEzTgi2n2c9d9iy+a2hYb3YLWw3a7
X-Received: by 2002:a05:6402:5389:b0:6ab:7700:9371 with SMTP id
 4fb4d7f45d1cf-6b7224456f2mr59415a12.25.1794092640188; Sat, 07 Nov 2026
 15:04:00 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Mohammed omran <sanhokh30@gmail.com>
Date: Sun, 8 Nov 2026 02:03:47 +0300
X-Gm-Features: AclHuK8fvN_RHbZboMCjp-RMmJyk_kzro5PsZaodk-3alDu9g4XF-XHGq1MIChA
Message-ID: <CAGwSD7TLViPzzXuZ37=M=8RJZrCN_ODG=DA=pLiivG6Lys94jA@mail.gmail.com>
Subject: [PATCH request for v5.15.y] ksmbd deferred file_lock UAF fixes
 missing (CVE-2026-64396, CVE-2026-64437)
To: stable@vger.kernel.org
Cc: stfrench@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

three ksmbd deferred file-lock UAF fixes landed upstream in June 2026 and
were backported to 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.1.y, but did not
reach 5.15.y (5.15.225):
  f580d27e8928 ksmbd: fix use-after-free of a deferred file_lock on
double SMB2_CANCEL
  d20d1c8ba576 ksmbd: fix UAF of struct file_lock in SMB2_LOCK
deferred-lock cancellation (CVE-2026-64396)
  10f293a07f9e ksmbd: fix use-after-free of a deferred file_lock on
SMB2_CLOSE then SMB2_CANCEL (CVE-2026-64437)

Evidence:
- The CNA record for CVE-2026-64396 lists the 5.15 branch as affected
  (vulnerable since e2f34481b24d, "cifsd: add server-side procedures for
  SMB3") with no bound fix for it, while every later branch has one.
- The deferred-lock async machinery is fully present in 5.15.y's copy of
  the file (fs/ksmbd/smb2pdu.c): setup_async_work, release_async_work,
  smb2_remove_blocked_lock are all defined/used; note the file moved to
  fs/smb/server/smb2pdu.c in mainline, which may be why the backport
  tooling skipped it.
- linux-5.15.y's history for fs/ksmbd/smb2pdu.c (through 5.15.225,
  2026-11-06) contains CommitDate back to 2024-11 and shows no deferred
  lock fixes; the branch is actively maintained (fresh fixes landed on
  2026-10-30).

Note: 5.15.y predates all three fixes, so it holds the original form of
the UAF (a second SMB2_CANCEL -- or a SMB2_CANCEL after SMB2_CLOSE,
which gen1's guard does not special-case either -- re-fires the
registered cancel_fn over a freed struct file_lock, KASAN slab-UAF in
__locks_delete_block) without even the partial mitigation present
elsewhere.

Could you please queue the three commits for 5.15.y (gen1 first; the
other two apply on top; fs/ksmbd/ path applies to the 5.15 rename).

Thanks,
[ bnomran=E2=80=94 scofaild23]
