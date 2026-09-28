Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF913CE4B2
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621955; cv=pass; b=r/VP7Reiy40lPlLEES5GDe8SI0FjU90gRUVmPJj/X35+kNeoArgWV/sD/SS/wgCQPxQ7elUF/YPiAzZTerxdYJP6e2xmhoSNNDmAomKvzSxsT291O/qtM2tpYVJart+Q7eKb+0I3FiR4klZUzMrL10VAlNuqtQNqzrns/g+as7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621955; c=relaxed/simple;
	bh=zbxh97DfahtmVFw2yx/P+OI0PpzLVE463PD6gyDR+VQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bLOPw61N5geid7en+qifvYuBwQg25uZKEtMD5Z8lOgRhktjfI/H0mvhdOwOcKt7xi390HFcJ+USGVxsz5Hq9Xv/tBhEsTwBPQkijYUmqan3jXRhdv5g5EYeIFj8HoZ9TRe57TMguj42f2RdnLcrM0SBxZNNyedtaWpN30iq63x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALNlkfXN; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALNlkfXN"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8ef09e288so2200760e87.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 11:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790621950; cv=none;
        d=google.com; s=arc-20260327;
        b=GGwcBEKzWbsR+OQJ78DZyYknM1Wb0iZk0A8AD25f2Z5hGYjKuqevXd5CmmSZlStGx9
         fPGUsOSqQJY3NMgfqZFOlTSi+YuTS0kyMJgq7/xkh/1tk9wRGsfbWcxtS4PK9Xy2/lhP
         0yrQKanIEleH0Mgqiyjpjfjb3s22BMBzfdco8f5LNslOD29BzMZPLsM1kyqKRfmOZ4vk
         68wYWR12S3TD8hd8iVlD3AYA4SIAjR5j35+GH0iK6mJue7g0VyP/kFaTGyP7ClRr08UL
         s6nfTWsOC3LISklot1GZszII16z9oDlIZf39D/dfBSQYft0g7Fl9d8SL5gbN5sApSDL2
         K/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:sender:mime-version
         :dkim-signature;
        bh=2mj3lyrm7aE/R7y/QOz0OagCVKj44YeS0Sz+Yo0D/po=;
        fh=49inDDVfX6oPztFMr2J3vNAe3hRt7K9WVSRlk3v9oaQ=;
        b=KtCI8YXntUIKdC5QPZm+7dL+js3P1C/qzLY5oglul47/7jLoszkJusxhq4kTL7UE8h
         kzQjYOp81L0xzHx+L1wUWCmdHVB+geFRLso447lz2ajpifHLeo56rTIpIUabCaO/5557
         ZIh0U4exrBn61ahYU1WuLQneeXk4f9zYVap1SZ3/lFlE2hBrxn9M3T0zs1IjNxUg5cY+
         GBmKckdEGhQQHSfb1iH6yIlrr85Slm+CZqazyV+JDA9iPXj80gMX4zLj5JOadrCQbsYs
         PDT9HEOfyy+BWzRBNh4imRpcUVEQlzDIB1ews9UXJAdfk+k76m7Nr7oSUN0HDgnW4JGJ
         LaAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621950; x=1791226750; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:sender:mime-version
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2mj3lyrm7aE/R7y/QOz0OagCVKj44YeS0Sz+Yo0D/po=;
        b=ALNlkfXNuHGvk48OfekmkexPjAHnoMbcsmSB3p+GYTqQ/2wliYgKPKzGrseWFJNf6a
         5qOYy+y/brxPI6LgihssK3ElXOsT+OCYvaWcIgETehpKUIX/SFwoaXpkwcRNUIGDeySX
         +1p9YXd0w7CLVCkYd2X+RVRUwm11tnWty/dnVv9uzJtFBBr7Ulin5dikMzZwJDnKzFqi
         A8dbUJl7jQzgVOovGH2WaXL3ClgPnPimSBmDQjwv6/ECl45EfrEU6LPzPm+f8I1s+0ft
         qXJWynVqFiJbAf6aBJX/oDRl20hV58+2IYhqihGcGvbVWIzAmyJzrRLVq1fKvz1jAPUc
         DlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621950; x=1791226750;
        h=content-type:cc:to:subject:message-id:date:from:sender:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2mj3lyrm7aE/R7y/QOz0OagCVKj44YeS0Sz+Yo0D/po=;
        b=yS6dCJM3Udyh8VELcugPFIyOeWmCHx7FJmVyngG0S47Zvjro+20fE5+AP++sMGDxCY
         mXfsQWzVIOfUpU6Kp86YgYn1is2k54SiEtaTkpqZnADSRukWq2TwhGOwzK8x2q7a7T/V
         VuX+mtGOPhpV+XhdGCOpwFMBJX20hEApdyjd79JBFyahCra+rbb+8cSuUwRmqJ2CItvy
         H9NXT+Pj1yY8x7mbVfN/qcOLNJOVQhvCP4j6JScrrP9umDmdVjcaAz0IMlps0cugWl00
         PUL2nuE7XUlq2GRx8dOWeg6L4pm9s0NnqO+ZDkBhYOk12GYYDNGFbxSGgkjHy1nnGdot
         eX5Q==
X-Forwarded-Encrypted: i=1; AKwUvBzDFZxgRWt3U1vGFjh3im497BQIdSfqYntB087J3lA3v9SPcErO/TLUUocX92irBbaSBiOaWhk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJM7kaDUyrM5qrNNM+RBpDpNLvMq3J9TAKB5qndYNCoGlRmFe/m
	EWVOBXFISV/GsKixYjbSYaYUaGRuYlTzKr+u8mWfRsER1Cd6hIbaM7xeV4Gb3igKO8LXtW42hzE
	zxIofhk6NcI4EIPLICdWvcKvakU1g6lk=
X-Gm-Gg: AYBFou1+MT1gZ8TtykVrEVxYJ0W8NKUfkTqAym4zm6dimZHChUvGaBTaUV5Tcpyva5g
	eS70am1cTSFUhO2Y4gZaadaZhEYv6lkygTvhjavRvBVwGfNlTFWvzTPO12/ricInggdgLErK4no
	mcRS7LMsyU6vfsAfOnDQ6nKZEzvLVAZuIhlkiPkG/ssBjtGbjKgiGN3/4S29iL8UItsPytIHpzu
	bbeK6ACfdueHdXZsYO6opJvGgPHvHTy3tDE46sq7iNb0EYRvZKHqV4FQAcKmPg9v4ePDXT/UdrF
	HVZDP3WW+uTTY0XX/gVvxDlS747b0bNUj+WxQZvqyGIiqVwKLELak4RwLFOL266NkaBzSgflGvM
	kBt8brSsSEeXj
X-Received: by 2002:a05:6512:230f:b0:5b8:f30f:7cfe with SMTP id
 2adb3069b0e04-5b8f30f7de0mr2381443e87.36.1790621949786; Mon, 28 Sep 2026
 11:59:09 -0700 (PDT)
Received: from 254448290189 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 11:59:08 -0700
Received: from 254448290189 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 11:59:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
From: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
Date: Mon, 28 Sep 2026 11:59:08 -0700
X-Google-Sender-Auth: yJdVTHyK8StYuaczuakEtPmSH0s
X-Gm-Features: AclHuK-Xz52AgVCzLAZuF5oizm1zR161dvYMBuInRdqEcsrUcYBfED0bFxZLpG4
Message-ID: <CAANnmVB6Wu+vtdmg+S5uZKkdYMA1gOSQBQ25SpSpasKG9U-1-g@mail.gmail.com>
Subject: [PATCH] fs/adfs: check name length of big directory entries
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, rmk+kernel@armlinux.org.uk, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The F+ (big directory) entry format stores the object name length on
disc as a 32-bit value, bigdirobnamelen.  adfs_fplus_getnext() stores
this value in struct object_info::name_len and then copies that many
bytes from the directory buffers into the fixed-size obj->name array
with adfs_dir_copyfrom(), which only validates the source range, not
the destination.

Nothing validates bigdirobnamelen, so a corrupt or maliciously
crafted filesystem image can specify a name length greater than
sizeof(obj->name), causing up to 4MB of attacker-controlled data to
be written past the end of the array.  Both callers of ->getnext()
instantiate struct object_info on their stacks - adfs_fplus_iterate()
via readdir() and adfs_lookup() via path resolution - so this is a
stack buffer overflow which is trivially triggered by listing or
stat'ing files on a crafted image.

adfs_object_fixup() also appends a four character ",xxx" filetype
suffix to the names of non-directory objects when the ftsuffix mount
option is enabled, so name lengths greater than ADFS_FPLUS_NAME_LEN
could still overflow the buffer by up to four bytes even when the
initial copy itself fits.

Reject entries whose name length exceeds the maximum defined for the
F+ format, which also leaves room for the filetype suffix.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
---
 fs/adfs/dir_fplus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 4a15924014da..ec663bc12a92 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -192,6 +192,11 @@ adfs_fplus_getnext(struct adfs_dir *dir, struct
object_info *obj)
 	obj->indaddr  = le32_to_cpu(bde.bigdirindaddr);
 	obj->attr     = le32_to_cpu(bde.bigdirattr);
 	obj->name_len = le32_to_cpu(bde.bigdirobnamelen);
+	if (obj->name_len > ADFS_FPLUS_NAME_LEN) {
+		adfs_error(dir->sb, "object name length %u exceeds maximum",
+			   obj->name_len);
+		return -ENAMETOOLONG;
+	}

 	offset = adfs_fplus_offset(h, le32_to_cpu(h->bigdirentries));
 	offset += le32_to_cpu(bde.bigdirobnameptr);
-- 
2.47.3
