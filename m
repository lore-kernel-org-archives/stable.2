Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792438625;
	b=qYYicCrqlYauzOi/65fh3lHt9kgW2hnV3kym8HXDycLG2CqJf/pDF29T1Lzl8WWekxju
	 Cp7c6muiH8YKklqwHB2Jqo1/UNeMYaFD/Uv4BlQQfe0U64/nbFEpDjoCxZ1f61HJJpQgF
	 xk8+FM9ESNhF1z39NFQOyik/5if7vKiC9C5T5mEK85ZeOnkUyuWWXNShrpA5Zcxt2bflo
	 KMg2fad8c/vSeH/WhFJ0Kpk/j4esJNBB66xUKYL5qmXQBJ4cBzx9ncNlpY1h9mJvsMNk5
	 BDcKz4KUKpmsnn7NefNWll+buneHdNiiV1/wA9O9SjRJ07q9vC7Bt+lQTkvUs9z/V9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792438625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FvmBdp1Dmbv2yJxDADj49tSTGQ/TMgCg8VxwxHkXYlo=;
	b=5FV0uPmCLcD8dhIyYuq0PQnCC3l/xZNBO23W6VxlvZIw0maC6aUYrxhiVUZKGyRX0jQg
	 kCg20c2mOvQgv4y4PxTy8lPfsVT1OX1wRfZVsL56fTAzH+HJlZ4uwx5eXACP7iFybH9LO
	 iFwKrv0n9p4ngr3QepZsMGW3WG5/cfgBUSvflyTbdYg5NQHbDWASKOtNc58KYv6cLfG+K
	 RAtfp/xJoXQ/8+o4kJ+1oI6ThhS5AAyhfw3nehKS75Eu9XWQp+DTPf9jQyQ6wqpUQWE4K
	 zY9rwQo5/RNgtotCEwsPB/rSR0GDXWmbpxZ3r88ekslu+QqXKzFFAb9GYZIcnBKuLqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jw5RywPK;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7A606A331
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 19:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBC7A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jw5RywPK
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7cc0fb88c90so70552137.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 12:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792438624; x=1793043424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FvmBdp1Dmbv2yJxDADj49tSTGQ/TMgCg8VxwxHkXYlo=;
        b=jw5RywPKPKu5GRuRcgskbWzYFCcD0g5ucpK/qpfpLuQnp1pSH1ynMYoeytWy48VM4k
         suzFSX1RFLmCUJgW99Iynkwr4NE5nZtOuGbuBZ1GGdBE/QAsaWm4C8v1WVfTMeTEISFf
         xqlXdHqwHYInPfjieQqVTCq2gdk4mlEqNuEiPo8oZLqmvY3sZiumaBaqNK3ZbeEPDeAa
         vgVsgV4hVrmK4EL2oE64PxVWLGFXBTNcSNiLsQjX8OrL5PhKfpOKbzS93DG/nlvJx1RQ
         UQ7E841Ph1Nv377dSka7PzCTVAM1Ib3FDg6lUs1St2SkzifXXjNFjEVEf4emzEtnEino
         F2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792438624; x=1793043424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FvmBdp1Dmbv2yJxDADj49tSTGQ/TMgCg8VxwxHkXYlo=;
        b=KzdzZiPlgl8QRrHncRqnWbUmInfLbsxdxLBENehGIiF4vPvg+q61l5DzozLIW+3hBO
         +FOtMccVac4k5viQSntr0+W8wvpHb8hvJuWeEpjAMShfK8lNILWyI4u+BSxy4VlPYKmo
         apP3OqPW9D3iM9WHrV/XEeu15rnRWORXkt4NvFf02oDuhMQU83hGnHLWxfVmy6bBFmAN
         znNDfpolwSJDdg2+kahoKR8KOJYKQzL05fR9Xa/F0/YCcDoDuzQOKbTqyGw/UwG5t4Ht
         qCyLSOIoiK7brWLPf2MUSsM0jh+USLLp/MqXydqf9rFY7kIhvq/O5MfN5K/lQ9BblC4f
         GbPw==
X-Forwarded-Encrypted: i=1; AKwUvByLy0EPGITMiJSt/+LFp5bcE92vUOhyL3BTdkOmdoLSvr1o9L581rgwrdXsWsx+SuqblYnte7A=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7DeYD1aVVT+kc57W7GAUZpDA9E3gLaxDVV2HanvnTPDwUX2H6
	lZK5/o4GXeVMANh1TI1VcUF//lXWeZ3Li8bBtpohYDX+TMPZkuAtRji4
X-Gm-Gg: AYBFou31x0SibnD9HNQTgOLgs6uqKqNBlhLCP5WBRGQXypVHUEZEMSiuDtW1+XmYwfK
	wqahlDAwdQN7eRXbUFTJOTvuSpziLegjL1hFNJtZAiSZbMvXRHTWn68ZhtUb7R95jsjP8Pz76g5
	GQsMV+jjHnKdZAfOIWeQUsmMGrec5X1g+zFbY+dUjWpSK5i9vun4KDO9/7FWz5KW0L/BjRgBLxF
	0wb6nVavvLvrApR+MGMplN6GCV7ze7Y6VdCoLriP66cVkErERsiMVErMXi7eVj2OSM5VhBORSsU
	v9Cq+qgGq7HJ7mEXI3Lo6PgQbAn7w5laNyLKj+UOCAabgKcBcS7xSDhgKdUIyWvrMKbrdsBZSR+
	kHz4rNXhT2xgh0Y4bj2DrDFJMj/0V27BlIuMA86J8OpS7Bu4jZ59ae/Ha0hi+yvrkmMgawNJGsD
	jaq0L+HzXD7DtdXgqYIQadmcHdFx/rWVDp9AWJkmU92z7utcaMAOaJhGYIqlyeOKrRQbw/wPzXK
	SFjY+6lON+pC3GbfSgOfoXxlM61jkgtumk1FYv2LVJh+Vwi5uOlISwQ8FDYP/BUXXC2wMYSOqIR
	D9/cRKaOWO2VHqdrlds=
X-Received: by 2002:a05:6102:1624:b0:7c3:99a3:314e with SMTP id ada2fe7eead31-7cc364a294amr1425709137.0.1792438623550;
        Mon, 19 Oct 2026 12:37:03 -0700 (PDT)
Received: from localhost.localdomain ([132.170.205.109])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990bb335be9sm1057850241.3.2026.10.19.12.37.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 12:37:03 -0700 (PDT)
From: Sanan Hasanov <sanan.hasanou@gmail.com>
To: Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+0b672810a475890d3636@syzkaller.appspotmail.com,
	Sanan Hasanov <sanan.hasanov@ucf.edu>,
	stable@vger.kernel.org
Subject: [PATCH] md: don't allow changing the personality of a failed array
Date: Mon, 19 Oct 2026 15:36:59 -0400
Message-ID: <20261019193659.31381-1-sanan.hasanou@gmail.com>
X-Mailer: git-send-email 2.48.1
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

From: Sanan Hasanov <sanan.hasanov@ucf.edu>

level_store() lets userspace switch a running array to another
personality through the takeover path, and then ignores the return value
of pers->run(). Takeover is expected to always produce something the new
personality can run, but that no longer holds for an array that has
already failed: since commit 57668f0a4cc4 ("raid5: introduce MD_BROKEN"),
has_failed() treats MD_BROKEN as fatal, so raid5_run() refuses such an
array. It then frees the new conf and clears mddev->private, while
level_store() has already installed the raid5 personality and freed the
old one. The array is left with mddev->pers == &raid5_personality and
mddev->private == NULL, and the next operation that reaches the
personality dereferences NULL:

  md/raid0md0: Disk failure on loop0 detected, failing array.
  md/raid:md0: not enough operational devices (1/3 failed)
  md/raid:md0: failed to run raid set.
  KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
  RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:210
  Call Trace:
   spin_lock_irq include/linux/spinlock_rt.h:96 [inline]
   lock_all_device_hash_locks_irq drivers/md/raid5.c:107 [inline]
   raid5_quiesce+0xc2/0x8a0 drivers/md/raid5.c
   __md_stop_writes+0xeb/0x4b0 drivers/md/md.c:7038
   md_set_readonly+0x330/0x560 drivers/md/md.c:7138
   array_state_store+0x584/0xe90 drivers/md/md.c:4720

syzbot gets there by failing a member of a raid0 array, which sets
MD_BROKEN, then writing "raid5" to md/level and "readonly" to
md/array_state. The same applies to a two-disk raid1 array whose last
working device has failed: raid1_error() sets MD_BROKEN but leaves
degraded at 1, so raid5_takeover_raid1() still accepts it.

MD_BROKEN is never cleared while the array is running, and a failed
array can't be turned into a working one by changing its level. Refuse
the change up front with -EBUSY, which is also what state_store()
returns when failing a device leaves the array broken.

Fixes: 57668f0a4cc4 ("raid5: introduce MD_BROKEN")
Reported-by: syzbot+0b672810a475890d3636@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0b672810a475890d3636
Cc: stable@vger.kernel.org
Signed-off-by: Sanan Hasanov <sanan.hasanov@ucf.edu>
---
 drivers/md/md.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 680b34a63c..367b183f1e 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4088,6 +4088,12 @@ level_store(struct mddev *mddev, const char *buf, size_t len)
 	    mddev->sysfs_active)
 		goto out_unlock;
 
+	if (test_bit(MD_BROKEN, &mddev->flags)) {
+		pr_warn("md: %s: cannot change personality of a failed array\n",
+			mdname(mddev));
+		goto out_unlock;
+	}
+
 	rv = -EINVAL;
 	if (!mddev->pers->quiesce) {
 		pr_warn("md: %s: %s does not support online personality change\n",
-- 
2.34.1

